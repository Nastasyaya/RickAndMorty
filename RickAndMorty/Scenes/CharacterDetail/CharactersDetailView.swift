//
//  CharactersDetailView.swift
//  RickAndMorty
//
//  Created by Анастасия Кутняхова on 04.12.2024.
//

import SwiftUI

struct CharactersDetailView: View {
    @StateObject var viewModel: CharactersDetailViewModel
    @Binding var isDetailShowing: Bool
    
    let navigationTitle: String
    @ViewBuilder let cachedImageViewBuilder: (
        _ image: String,
        _ frame: CGFloat
    ) -> CachedImageView
    
    var body: some View {
        ZStack {
            Color.backgroundsPrimary.ignoresSafeArea()
            
            VStack {
                CustomNavigationTitle(
                    label: navigationTitle,
                    action: viewModel.backTapped
                )
                
                ScrollView {
                    viewModel.character.map {
                        CharacterDetailCardView(
                            isFavorite: $viewModel.isFavorite,
                            viewModel: $0,
                            cachedImageViewBuilder: cachedImageViewBuilder
                        )
                    }
                }
            }
        }
        .onAppear {
            withAnimation {
                isDetailShowing.toggle()
            }
            viewModel.onAppear()
        }
        .onDisappear {
            isDetailShowing.toggle()
        }
        .navigationBarBackButtonHidden()
    }
}
