//
//  FavoritesViewModel.swift
//  RickAndMorty
//
//  Created by Анастасия Кутняхова on 13.10.2024.
//

import Combine
import Foundation

final class FavoritesViewModel: ObservableObject {
    enum State: Equatable {
        case empty
        case content(cards: [CharacterListRowViewModel])
    }
    
    struct Dependencies {
        let contentConverter: FavoritesContentConverter
        let storage: FavoritesStorage
    }
    
    struct Parameters {
        let onDetailTap: (_ character: Character) -> Void
    }
    
    @Published private(set) var state: State = .empty
        
    private let dependencies: Dependencies
    private let parameters: Parameters
    private let scheduler: MainScheduler
    
    init(
        dependencies: Dependencies,
        parameters: Parameters,
        scheduler: MainScheduler = .create()
    ) {
        self.dependencies = dependencies
        self.parameters = parameters
        self.scheduler = scheduler
        
        observeFavorites()
        getFavorites()
    }
}

// MARK: - ObserveFavorites
private extension FavoritesViewModel {
    func observeFavorites() {
        dependencies.storage.observeFavorites()
            .map { [weak self] characters in
                guard let self = self else { return .empty }

                return characters.isEmpty ? .empty : .content(cards: makeContent(from: characters))
            }
            .receive(on: scheduler)
            .assign(to: &$state)
    }
}

// MARK: - GetFavorites
private extension FavoritesViewModel {
    func getFavorites() {
        let favorites = Array(dependencies.storage.getFavorites().values)
        state = favorites.isEmpty ? .empty : .content(cards: makeContent(from: favorites))
    }
}

// MARK: - MakeContent
private extension FavoritesViewModel {
    func makeContent(
        from characters: [Character]
    ) -> [CharacterListRowViewModel] {
        dependencies.contentConverter.convert(
            from: characters,
            onTap: { [weak self] character in
                self?.parameters.onDetailTap(character)
            }
        )
    }
}
