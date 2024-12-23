//
//  FavoritesView.swift
//  RickAndMorty
//
//  Created by Анастасия Кутняхова on 05.10.2024.
//

import SwiftUI

struct FavoritesView: View {
    @StateObject var viewModel: FavoritesViewModel
    
    @ViewBuilder let cachedImageViewBuilder: (
        _ url: String,
        _ frame: CGFloat
    ) -> CachedImageView
    
    var body: some View {
        VStack {
            CustomNavigationBarView(title: "Favorites")
            
            Group {
                switch viewModel.state {
                case .empty:
                    Text("No favorites yet")
                        .font(.custom("Inter", size: 18))
                        .foregroundStyle(.foregroundsTertiary)
                        .centerVertically()
                    
                case .content(cards: let favorites):
                    BaseScrollView {
                        ForEach(favorites) { favorite in
                            CharacterListRowView(
                                viewModel: favorite,
                                cachedImageViewBuilder: cachedImageViewBuilder
                            )
                        }
                    }
                }
            }
        }
        .background {
            Color.backgroundsPrimary.ignoresSafeArea()
        }
    }
}

#Preview {
    let manager = NetworkingManagerImp.shared
    let contentConverter = FavoritesContentConverterImp()
    let cachedImageService = CachedImageServiceImp(manager: manager)
    let storage = FavoritesStorageImp()
    
    FavoritesView(
        viewModel: FavoritesViewModel(
            dependencies: FavoritesViewModel.Dependencies(
                contentConverter: contentConverter,
                storage: storage
            ),
            parameters: FavoritesViewModel.Parameters(onDetailTap: { _ in })
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
}
