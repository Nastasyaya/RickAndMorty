@testable import RickAndMorty
import Combine
import XCTest

final class FavoritesViewModelTests: XCTestCase {
    func test_givenInitialized_whenNoFavorites_thenStateIsEmpty() {
        // Given
        let sut = makeSUT()
        
        // Then
        XCTAssertEqual(sut.state, .empty)
    }
    func test_givenInitialized_whenFavoritesExist_thenStateIsContent() {
        // Given
        let contentConverter = FavoritesContentConverterSpy(
            convertReturn: [.makeMock()]
        )
        let storage = FavoritesStorageSpy(
            getAllCharactersReturn: [.makeMock()],
            getFavoritesReturn: [1: .makeMock()],
            observeFavoritesReturn: .makeMock(output: [.makeMock(id: 1)])
        )
        let sut = makeSUT(
            contentConverter: contentConverter,
            storage: storage
        )
        
        // Then
        XCTAssertEqual(sut.state, .content(cards: [.makeMock()]))
    }
    
    func test_whenCharactersObserved_thenStateIsContent() {
        let contentConverter = FavoritesContentConverterSpy(
            convertReturn: []
        )
        let storage = FavoritesStorageSpy(
            getAllCharactersReturn: [],
            getFavoritesReturn: [:],
            observeFavoritesReturn: .makeMock(output: [.makeMock()])
        )
        let scheduler = TestScheduler.create()
        let sut = makeSUT(
            contentConverter: contentConverter,
            storage: storage,
            scheduler: scheduler.asMainScheduler
        )
        scheduler.advance()

        // Then
        XCTAssertEqual(contentConverter.convertCalls.count, 1)
        XCTAssertEqual(sut.state, .content(cards: contentConverter.convertReturn))
    }
    
    func test_whenNoCharactersObserved_thenStateIsEmpty() {
        // Given
        let contentConverter = FavoritesContentConverterSpy(
            convertReturn: [.makeMock()]
        )
        let storage = FavoritesStorageSpy(
            getAllCharactersReturn: [],
            getFavoritesReturn: [:],
            observeFavoritesReturn: .makeMock(output: [])
        )
        
        let sut = makeSUT(
            contentConverter: contentConverter,
            storage: storage
        )
        
        // Then
        XCTAssertEqual(sut.state, .empty)
    }
    
    func test_whenDetailTapped_thenActionExecuted() {
        // Given
        var receivedCharacter: Character?
        let contentConverter = FavoritesContentConverterSpy(
            convertReturn: [.makeMock()]
        )
        let storage = FavoritesStorageSpy(
            getAllCharactersReturn: [.makeMock()],
            getFavoritesReturn: [1: .makeMock()],
            observeFavoritesReturn: .makeMock(output: [.makeMock(id: 1)])
        )
        let sut = makeSUT(
            contentConverter: contentConverter,
            storage: storage,
            onDetailTap: { character in
                receivedCharacter = character
            }
        )
        _ = sut.state
        
        // When
        contentConverter.convertCalls.first?.onTap(.makeMock())
        
        // Then
        XCTAssertNotNil(receivedCharacter)
    }
}

private extension FavoritesViewModelTests {
    func makeSUT(
        characters: [Character] = [.makeMock()],
        contentConverter: FavoritesContentConverter = FavoritesContentConverterSpy(
            convertReturn: [.makeMock()]
        ),
        storage: FavoritesStorage = FavoritesStorageSpy(
            getAllCharactersReturn: [.makeMock()],
            getFavoritesReturn: [:],
            observeFavoritesReturn: .makeEmptyMock()
        ),
        scheduler: MainScheduler = .create(),
        onDetailTap: @escaping (Character) -> Void = { _ in }
    ) -> FavoritesViewModel {
        FavoritesViewModel(
            dependencies: FavoritesViewModel.Dependencies(
                contentConverter: contentConverter,
                storage: storage
            ),
            parameters: FavoritesViewModel.Parameters(
                onDetailTap: onDetailTap
            ),
            scheduler: scheduler
        )
    }
}
