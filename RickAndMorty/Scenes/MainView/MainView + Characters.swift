//
//  MainView + Characters.swift
//  RickAndMorty
//
//  Created by Анастасия Кутняхова on 04.12.2024.
//

import Foundation

extension MainView {
    func makeCharactersFlow() -> CharactersFlow {
        CharactersFlow(
            dependencies: CharactersFlow.Dependencies(
                charactersViewBuilder: makeCharactersView,
                charactersDetailViewBuilder: {
                    character,
                    onBack in
                    makeCharactersDetailView(
                        character: character,
                        onBack: onBack,
                        navigationTitle: "Characters"
                    )
                }
            )
        )
    }
}

// MARK: - Сonverter
private extension MainView {
    func makeContentConverter() -> some CharactersContentConverter {
        CharactersContentConverterImp()
    }
}

// MARK: - Service
private extension MainView {
    func makeCharactersService() -> some CharactersService {
        CharactersServiceImp(manager: manager)
    }
}

// MARK: - View
private extension MainView {
    func makeCharactersView(
        onDetailTap: @escaping (_ character: Character) -> Void
    ) -> CharactersView {
        
        CharactersView(
            viewModel: makeCharactersViewModel(
                parameters: CharactersViewModel.Parameters(
                    onDetailTap: onDetailTap
                )
            ),
            cachedImageViewBuilder: makeCachedImageView
        )
    }
}

// MARK: - ViewModel
private extension MainView {
    func makeCharactersViewModel(
        parameters: CharactersViewModel.Parameters
    ) -> CharactersViewModel {
        CharactersViewModel(
            dependencies: CharactersViewModel.Dependencies(
                contentConverter: makeContentConverter(),
                charactersService: makeCharactersService(),
                storage: storage
            ),
            parameters: parameters
        )
    }
}
