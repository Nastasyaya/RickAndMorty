@testable import RickAndMorty
import XCTest

final class CharactersDetailViewModelTests: XCTestCase {
    func test_givenInitialized_thenValuesMatched() {
        // Given
        let sut = makeSUT()

        // Then
        XCTAssertFalse(sut.isFavorite)
        XCTAssertNil(sut.character)
    }

    func test_givenInitialized_whenOnAppeared_thenCharacterShown() {
        // Given
        let contentConverter = CharacterDetailContentConverterSpy(
            convertReturn: .makeMock()
        )
        let sut = makeSUT(
            character: .makeMock(),
            contentConverter: contentConverter
        )

        // When
        sut.onAppear()

        // Then
        XCTAssertEqual(contentConverter.convert.count, 1)
        XCTAssertEqual(sut.character, contentConverter.convertReturn)
    }

    func test_whenBackTapped_thenActionExecuted() {
        // Given
        var isActionExecuted = false
        let sut = makeSUT(
            onBack: {
                isActionExecuted = true
            }
        )

        // When
        sut.backTapped()

        // Then
        XCTAssertTrue(isActionExecuted)
    }

    func test_givenIDsMatched_whenFavoritesObserved_thenUpdateIsFavoriteValue() {
        // Given
        let storage = FavoritesStorageSpy(
            getAllCharactersReturn: [],
            getFavoritesReturn: [2: .makeMock()],
            observeFavoritesReturn: .makeEmptyMock()
        )
        let sut = makeSUT(
            character: .makeMock(id: 2),
            storage: storage
        )

        // Then
        XCTAssertEqual(storage.getFavoritesCount, 1)
        XCTAssertTrue(sut.isFavorite)
    }

    func test_givenIsNotFavoriteCharacter_whenIsBecameFavorite_thenCharacterIDSended() {
        // Given
        let storage = FavoritesStorageSpy(
            getAllCharactersReturn: [.makeMock(id: 2)],
            getFavoritesReturn: [:],
            observeFavoritesReturn: .makeMock(output: [.makeMock(id: 2)])
        )
        let sut = makeSUT(storage: storage)

        // When
        sut.isFavorite = true

        // Then
        XCTAssertEqual(storage.sendID.count, 1)
    }

    func test_givenIsFavoriteCharacter_whenIsBecameNotFavorite_thenCharacterIDRemoved() {
        // Given
        let storage = FavoritesStorageSpy(
            getAllCharactersReturn: [.makeMock(id: 2)],
            getFavoritesReturn: [:],
            observeFavoritesReturn: .makeMock(output: [.makeMock(id: 2)])
        )
        let sut = makeSUT(storage: storage)
        sut.isFavorite = true

        // When
        sut.isFavorite = false

        // Then
        XCTAssertEqual(storage.remove.count, 1)
    }
}

private extension CharactersDetailViewModelTests {
    func makeSUT(
        character: Character = .makeMock(),
        contentConverter: CharacterDetailContentConverter = CharacterDetailContentConverterSpy(
            convertReturn: .makeMock()
        ),
        storage: FavoritesStorage = FavoritesStorageSpy(
            getAllCharactersReturn: [.makeMock()],
            getFavoritesReturn: [:],
            observeFavoritesReturn: .makeEmptyMock()
        ),
        onBack: @escaping () -> Void = {}
    ) -> CharactersDetailViewModel {
        CharactersDetailViewModel(
            dependencies: CharactersDetailViewModel.Dependencies(
                contentConverter: contentConverter,
                storage: storage
            ),
            parameters: CharactersDetailViewModel.Parameters(
                character: character
            ),
            onBack: onBack
        )
    }
}
