//
//  MainView + CharactersDetail.swift
//  RickAndMorty
//
//  Created by Анастасия Кутняхова on 04.12.2024.
//

// MARK: - CharactersDetailView
extension MainView {
    func makeCharactersDetailView(
        character: Character,
        onBack: @escaping () -> Void,
        navigationTitle: String
    ) -> CharactersDetailView {
        CharactersDetailView(
            viewModel: makeCharactersDetailViewModel(
                parameters: CharactersDetailViewModel.Parameters(
                    character: character
                ),
                onBack: onBack
            ),
            isDetailShowing: $isDetailShowing,
            navigationTitle: navigationTitle,
            cachedImageViewBuilder: makeCachedImageView
        )
    }
}

// MARK: - ViewModels
private extension MainView {
    func makeCharactersDetailViewModel(
        parameters: CharactersDetailViewModel.Parameters,
        onBack: @escaping () -> Void
    ) -> CharactersDetailViewModel {
        
        CharactersDetailViewModel(
            dependencies: CharactersDetailViewModel.Dependencies(
                contentConverter: makeChararcerDetailContentConverter(),
                storage: storage
            ),
            parameters: parameters,
            onBack: onBack
        )
    }
}

// MARK: - ContentConverter
private extension MainView {
    func makeChararcerDetailContentConverter() -> some
    CharacterDetailContentConverter
    {
        CharactersDetailContentConverterImp()
    }
}
