////
////  CharactersFlow.swift
////  RickAndMorty
////
////  Created by Анастасия Кутняхова on 05.10.2024.
////

import SwiftUI

struct CharactersFlow: View {
    struct Dependencies {
        @ViewBuilder let charactersViewBuilder: (
            _ onDetailTap: @escaping (_ character: Character) -> Void
        ) -> CharactersView
        
        @ViewBuilder let charactersDetailViewBuilder: (
            _ character: Character,
            _ onBackTap: @escaping () -> Void
        ) -> CharactersDetailView
    }
    
    private enum Destination: Hashable {
        case characterDetail(character: Character)
    }
    
    @State private var path: [Destination] = []
    
    let dependencies: Dependencies
    
    var body: some View {
        NavigationStack(path: $path) {
            dependencies.charactersViewBuilder { character in
                path.append(.characterDetail(character: character))
            }
            .navigationDestination(for: Destination.self) { destination in
                switch destination {
                case let .characterDetail(character):
                    dependencies.charactersDetailViewBuilder(
                        character,
                        { path.removeLast() }
                    )
                }
            }
        }
    }
}
