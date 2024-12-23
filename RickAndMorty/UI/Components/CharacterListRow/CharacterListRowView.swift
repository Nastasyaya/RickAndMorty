//
//  ChatacterRow.swift
//  RickAndMorty
//
//  Created by Анастасия Кутняхова on 04.10.2024.
//

import SwiftUI

struct CharacterListRowView: View {
    let viewModel: CharacterListRowViewModel
    let isSearchCard: Bool
    private let cachedImageViewBuilder: (
        _ image: String,
        _ frame: CGFloat
    ) -> CachedImageView
    
    init(
        viewModel: CharacterListRowViewModel,
        isSearchCard: Bool = false,
        @ViewBuilder cachedImageViewBuilder: @escaping (
            _ image: String,
            _ frame: CGFloat
        ) -> CachedImageView
    ) {
        self.viewModel = viewModel
        self.isSearchCard = isSearchCard
        self.cachedImageViewBuilder = cachedImageViewBuilder
    }
    
    var body: some View {
        Button {
            viewModel.onTap()
        } label: {
            content
        }
        .background {
            RoundedRectangle(cornerRadius: 16)
                .fill(.backgroundsTertiary)
                .shadow(color: .black.opacity(0.1) , radius: 3)
                .isVisible(isSearchCard)
        }
    }

    private var content: some View {
        HStack() {
            HStack(alignment: .top, spacing: 16) {
                cachedImageViewBuilder(viewModel.image, 44)
                
                texts
                
                Spacer()
            }
            
            chevron
        }
        .padding(8)
    }
    
    private var texts: some View {
        VStack(alignment: .leading, spacing: .zero) {
            HStack(spacing: .zero) {
                Text(viewModel.name)
                    .font(.headline)
                    .fontWeight(.bold)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                
                if viewModel.isFavorite {
                    Image(.favoritesStar16)
                        .renderingMode(.template)
                        .foregroundStyle(.iconsTertiary)
                        .frame(width: 16, height: 16)
                        .padding(.vertical, 2)
                        .padding(.leading, 4)
                }
            }
            
            Text(viewModel.status)
                .fontWeight(.regular)
                .font(.custom("Inter", size: 16))
                .foregroundStyle(.foregroundsSecondary)
                .padding(.top, 2)
        }
    }
    
    private var chevron: some View {
        Image(systemName: "chevron.right")
            .foregroundStyle(.iconsSecondary)
            .frame(width: 24, height: 24)
            .isVisible(isSearchCard)
    }
}

#Preview {
    @Previewable @State var isFavorite: Bool = false

    ZStack {
        Color.white.ignoresSafeArea()

        CharacterListRowView(
            viewModel: CharacterListRowViewModel(
                id: 1,
                image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
                name: "Rick Sanchez",
                status: "Alive",
                isFavorite: true,
                onTap: {}
            ),
            cachedImageViewBuilder: { url, frame in
                CachedImageView(
                    viewModel: CachedImageViewModel(
                        service: CachedImageServiceImp(
                            manager: NetworkingManagerImp.shared
                        ),
                        url: url,
                        scheduler: .create()
                    ),
                    frame: frame
                )
            }
        )
        .preferredColorScheme(.light)
    }
}
