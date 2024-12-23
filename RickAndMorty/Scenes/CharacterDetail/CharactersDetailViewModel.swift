//
//  CharactersDetailViewModel.swift
//  RickAndMorty
//
//  Created by Анастасия Кутняхова on 04.12.2024.
//

import Combine

final class CharactersDetailViewModel: ObservableObject {
    @Published var isFavorite: Bool = false
    @Published private(set) var character: CharacterDetailCardViewModel?
    
    struct Dependencies {
        let contentConverter: CharacterDetailContentConverter
        let storage: FavoritesStorage
    }
    
    struct Parameters {
        let character: Character
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    private let dependencies: Dependencies
    private let parameters: Parameters
    private let onBack: () -> Void
    
    init(
        dependencies: Dependencies,
        parameters: Parameters,
        onBack: @escaping () -> Void
    ) {
        self.dependencies = dependencies
        self.parameters = parameters
        self.onBack = onBack

        observeFavoriteState()
    }
    
    func onAppear() {
        character = dependencies.contentConverter.convert(
            character: parameters.character
        )
    }
    
    func backTapped() {
        onBack()
    }
}

// MARK: - ObserveFavoriteState
private extension CharactersDetailViewModel {
    func observeFavoriteState() {
        isFavorite = dependencies
            .storage
            .getFavorites()
            .keys
            .contains(where:{ $0 == parameters.character.id })
        
        $isFavorite
            .dropFirst()
            .sink { [weak self] isFavorite in
                self?.handle(isFavorite: isFavorite)
            }
            .store(in: &cancellables)
    }
    
    func handle(isFavorite: Bool) {
        if isFavorite {
            dependencies.storage.send(id: parameters.character.id)
        } else {
            dependencies.storage.remove(by: parameters.character.id)
        }
    }
}
