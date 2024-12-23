//
//  FavoritesFlow.swift
//  RickAndMorty
//
//  Created by Анастасия Кутняхова on 05.10.2024.
//

import SwiftUI

struct FavoritesFlow: View {
    struct Dependencies {
        @ViewBuilder let favoritesViewBuilder: (
            _ onDetailTap: @escaping (_ character: Character) -> Void
        ) -> FavoritesView
        @ViewBuilder let favoritesDetailViewBuilder: (
            _ character: Character,
            _ onBack: @escaping () -> Void
        ) -> CharactersDetailView
    }
    
    private enum Destination: Hashable {
        case characterDetail(character: Character)
    }
    
    @State private var path: [Destination] = []
    
    let dependencies: Dependencies
    
    var body: some View {
        NavigationStack(path: $path) {
            dependencies.favoritesViewBuilder { character in
                path.append(.characterDetail(character: character))
            }
            .navigationDestination(for: Destination.self) { destination in
                switch destination {
                case let .characterDetail(character):
                    dependencies.favoritesDetailViewBuilder(
                        character,
                        { path.removeLast() }
                    )
                }
            }
        }
    }
}
