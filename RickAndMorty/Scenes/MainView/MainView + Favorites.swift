//
//  MainView + Favorites.swift
//  RickAndMorty
//
//  Created by Анастасия Кутняхова on 04.12.2024.
//

extension MainView {
    func makeFavoritesFlow() -> FavoritesFlow {
        FavoritesFlow(
            dependencies: FavoritesFlow.Dependencies(
                favoritesViewBuilder: makeFavoritesView,
                favoritesDetailViewBuilder: { character, onBack in
                    makeCharactersDetailView(
                        character: character,
                        onBack: onBack,
                        navigationTitle: "Favorites"
                    )
                }
            )
        )
    }
}

// MARK: - Converter
private extension MainView {
    func makeFavoritesContentConverter() -> some FavoritesContentConverter {
        FavoritesContentConverterImp()
    }
}

// MARK: - View
private extension MainView {
    func makeFavoritesView(
        _ onDetailTap: @escaping (_ character: Character) -> Void
    ) -> FavoritesView {
        
        FavoritesView(
            viewModel: makeFavoritesViewModel(
                parameters: FavoritesViewModel.Parameters(
                    onDetailTap: onDetailTap
                )
            ),
            cachedImageViewBuilder: makeCachedImageView
        )
    }
}

// MARK: - ViewModel
private extension MainView {
    func makeFavoritesViewModel(
        parameters: FavoritesViewModel.Parameters
    ) -> FavoritesViewModel {
        
        FavoritesViewModel(
            dependencies: FavoritesViewModel.Dependencies(
                contentConverter: makeFavoritesContentConverter(),
                storage: storage
            ),
            parameters: parameters
        )
    }
}
