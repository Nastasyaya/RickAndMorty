//
//  CharacterDetailCardView.swift
//  RickAndMorty
//
//  Created by Анастасия Кутняхова on 05.10.2024.
//

import SwiftUI

struct CharacterDetailCardView: View {
    @Binding private var isFavorite: Bool
    
    private let viewModel: CharacterDetailCardViewModel
    private let cachedImageViewBuilder: (
        _ image: String,
        _ frame: CGFloat
    ) -> CachedImageView
    
    init(
        isFavorite: Binding<Bool>,
        viewModel: CharacterDetailCardViewModel,
        @ViewBuilder cachedImageViewBuilder: @escaping (
            _ image: String,
            _ frame: CGFloat
        ) -> CachedImageView
    ) {
        self._isFavorite = isFavorite
        self.viewModel = viewModel
        self.cachedImageViewBuilder = cachedImageViewBuilder
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: .zero) {
                characterImage
                
                headerSection
            }
            Divider()
                .foregroundStyle(.foregroundsSecondary)
            
            detailSection
        }
        .background {
            RoundedRectangle(cornerRadius: 16)
                .fill(.backgroundsTertiary)
                .shadow(color: .backgroundsPrimary.opacity(0.8), radius: 16)
        }
        .padding(.horizontal)
    }
    
    // MARK: - Image
    private var characterImage: some View {
        cachedImageViewBuilder(viewModel.image, 140)
            .padding(EdgeInsets(top: 16, leading: 16, bottom: 6, trailing: 16))
    }
    
    // MARK: - Header
    private var headerSection: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Name")
                    .font(.custom("Inter", size: 20))
                    .fontWeight(.bold)
                    .foregroundStyle(.foregroundsSecondary)
                
                Spacer()
                
                Button {
                    isFavorite.toggle()
                } label: {
                    Image(isFavorite ? .favoritesStar30 : .favoritesEnabledStar)
                        .renderingMode(.template)
                        .resizable()
                        .foregroundStyle(isFavorite ? .accentPrimary : .iconsSecondary)
                        .frame(width: 30, height: 30)
                }
            }
            Text(viewModel.name)
                .font(.title2)
                .fontWeight(.bold)
        }
        .padding(EdgeInsets(top: 18, leading: 0, bottom: 0, trailing: 16))
    }
    
    // MARK: - DetailSection
    private var detailSection: some View {
        VStack(spacing: 27) {
            CharactersDetailRowView(label: "Status", caption: viewModel.status)
            CharactersDetailRowView(label: "Species", caption: viewModel.species)
            CharactersDetailRowView(label: "Type", caption: viewModel.type)
            CharactersDetailRowView(label: "Gender", caption: viewModel.gender)
            CharactersDetailRowView(label: "Origin", caption: viewModel.origin)
            CharactersDetailRowView(label: "Location", caption: viewModel.location)
        }
        .padding(24)
    }
}

// MARK: - CharactersDetailRowView
struct CharactersDetailRowView: View {
    let label: String
    let caption: String
    
    var body: some View {
        HStack(alignment: .top) {
            Text(label)
                .fontWeight(.regular)
                .foregroundStyle(.foregroundsSecondary)
                .frame(width: 96, alignment: .leading)
            
            Text(caption)
                .fontWeight(.bold)
                .tint(.accentPrimary)
            
            Spacer()
        }
    }
}

// MARK: - PREVIEW
#Preview {
    @Previewable @State var isFavorite: Bool = false
    
    ZStack {
        CharacterDetailCardView(
            isFavorite: $isFavorite,
            viewModel: CharacterDetailCardViewModel(
                id: 1,
                name: "Rick Sanchez",
                status: "Alive",
                image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
                species: "Human",
                type: "-",
                gender: "Gender",
                origin: "Origin",
                location: "Earth (Replacement Dimension)"
            ),
            cachedImageViewBuilder: { _, _ in
                CachedImageView(
                    viewModel: CachedImageViewModel(
                        service: CachedImageServiceImp(manager: NetworkingManagerImp.shared),
                        url: "https://rickandmortyapi.com/api/character/avatar/1.jpeg"
                    ),
                    frame: 140
                )
            }
        )
    }
}
