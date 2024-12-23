//
//  CharactersView.swift
//  RickAndMorty
//
//  Created by Анастасия Кутняхова on 04.10.2024.
//

import SwiftUI

struct CharactersView: View {
    @StateObject var viewModel: CharactersViewModel
    @FocusState private var isFocused: Bool

    @ViewBuilder let cachedImageViewBuilder: (
        _ image: String,
        _ frame: CGFloat
    ) -> CachedImageView

    var body: some View {
        VStack {
            if !viewModel.isSearchActive {
                navigationTitle
            }
            
            BaseScrollView {
                searchBar
                
                if viewModel.isSearchActive {
                    searchResultsList
                } else {
                    switch viewModel.state {
                    case .content(let characters):
                        ForEach(characters) { character in
                            CharacterListRowView(
                                viewModel: character,
                                cachedImageViewBuilder: cachedImageViewBuilder
                            )
                            .onAppear {
                                viewModel.loadNextPage(character: character)
                            }
                        }
                    case .loading:
                        ProgressView()
                            .centerVertically()
                    case .error:
                        Text("Something going wrong, please refresh the screen")
                            .centerVertically()
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
        .background {
            Color.backgroundsPrimary
                .ignoresSafeArea()
        }
    }
    
    // MARK: - NavigationTitle
    private var navigationTitle: some View {
        CustomNavigationBarView(title: "Characters")
            .transition(.move(edge: .top).combined(with: .opacity))
    }
    
    // MARK: - SearchBar
    private var searchBar: some View {
        SearchBar(
            inputText: $viewModel.inputText,
            isFocused: _isFocused,
            onCancel: {
                viewModel.cancelSearch()
            }
        )
        .transition(.move(edge: .top))
        .onChange(
            of: isFocused,
            { _, newValue in
                withAnimation {
                    viewModel.isSearchActive = newValue
                    print("Active searching - \(newValue)")
                }
            }
        )
    }
    // MARK: - SearchResultsList
    private var searchResultsList: some View {
        ForEach(viewModel.searchResults) { result in
            CharacterListRowView(
                viewModel: result,
                isSearchCard: viewModel.isSearchActive,
                cachedImageViewBuilder: cachedImageViewBuilder
            )
        }
    }
}

// MARK: - Preview
#Preview {
    let manager = NetworkingManagerImp.shared
    let contentConverter = CharactersContentConverterImp()
    let cachedImageService = CachedImageServiceImp(manager: manager)
    let charactersService = CharactersServiceImp(manager: manager)
    let storage = FavoritesStorageImp()
    
    CharactersView(
        viewModel: CharactersViewModel(
            dependencies: CharactersViewModel.Dependencies(
                contentConverter: contentConverter,
                charactersService: charactersService,
                storage: storage
            ),
            parameters: CharactersViewModel.Parameters(
                onDetailTap: { _ in }
            )
        ),
        cachedImageViewBuilder: { url, frame in
            CachedImageView(
                viewModel: CachedImageViewModel(
                    service: cachedImageService,
                    url: url
                ),
                frame: frame
            )
        }
    )
    .preferredColorScheme(.light)
}
