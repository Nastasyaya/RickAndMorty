@testable import RickAndMorty
import XCTest

final class CharactersViewModelTests: XCTestCase {
    func test_whenCancelSearch_thanResetsState() {
        // Given
        let sut = makeSUT()
        sut.inputText = "foo"
        sut.searchResults = [.makeMock()]
        
        // When
        sut.cancelSearch()
        
        // Then
        XCTAssertEqual(sut.inputText, "")
        XCTAssertEqual(sut.searchResults, [])
    }
    
    func test_searchResults_shouldBeEmpty_whenInputTextIsEmpty() {
        // Given
        let contentConverter = CharactersContentConverterSpy(
            convertReturn: [.makeMock()]
        )
        
        let service = CharactersServiceSpy(
            getCharactersReturn: .makeEmptyMock(),
            searchCharacterReturn: .makeEmptyMock()
        )
        
        let sut = makeSUT(contentConverter: contentConverter, charactersService: service)
        
        let expectation = XCTestExpectation(description: "searchResults should be empty when inputText is empty")
        
        var observedResults: [CharacterListRowViewModel] = []
        let cancellable = sut.$searchResults
            .dropFirst()
            .sink { results in
                observedResults = results
                expectation.fulfill()
            }
        
        // When
        sut.inputText = ""
        
        // Then
        wait(for: [expectation], timeout: 2.0)
        
        XCTAssertTrue(observedResults.isEmpty)
        XCTAssertEqual(service.searchCharacterCalls.count, 0)
        
        cancellable.cancel()
    }

    
    func test_whenSearchCharacters_thenUpdatesSearchResults() {
        // Given
        let contentConverter = CharactersContentConverterSpy(
            convertReturn: [.makeMock()]
        )
        let service = CharactersServiceSpy(
            getCharactersReturn: .makeEmptyMock(),
            searchCharacterReturn: .makeMock(output: .makeMock())
        )
        let sut = makeSUT(
            contentConverter: contentConverter,
            charactersService: service
        )
        let expectation = XCTestExpectation(description: "searchResults should be updated after search")
        var observedResults: [CharacterListRowViewModel] = []
        let cancellable = sut.$searchResults
            .dropFirst()
            .sink { results in
                observedResults = results
                expectation.fulfill()
            }
        
        // When
        sut.inputText = "rick"
        
        // Then
        wait(for: [expectation], timeout: 2.0)

        XCTAssertEqual(service.searchCharacterCalls.count, 1)
        XCTAssertEqual(service.searchCharacterCalls.first?.name, "rick")
        XCTAssertEqual(observedResults.count, 1)
        
        cancellable.cancel()
    }
    
    func test_whenDetailTapped_thenActionExecuted() {
        // Given
        var recievedCharacter: Character?
        let charactersService = CharactersServiceSpy(
            getCharactersReturn: .makeMock(output: .makeMock()),
            searchCharacterReturn: .makeEmptyMock()
        )
        let contentConverter = CharactersContentConverterSpy(
            convertReturn: [.makeMock()]
        )
        let sut = makeSUT(
            contentConverter: contentConverter,
            charactersService: charactersService,
            onDetailTap: { character in
                recievedCharacter = character
            }
        )
        _ = sut.state
        
        // When
        contentConverter.convertCalls.first?.onDetailTapped( .makeMock())
        
        // Then
        XCTAssertNotNil(recievedCharacter)
    }
}

private extension CharactersViewModelTests {
    func makeSUT(
        characters: [Character] = [.makeMock()],
        contentConverter: CharactersContentConverter = CharactersContentConverterSpy(
            convertReturn: []
        ),
        charactersService: CharactersService = CharactersServiceSpy(
            getCharactersReturn: .makeEmptyMock(),
            searchCharacterReturn: .makeEmptyMock()
        ),
        storage: FavoritesStorage = FavoritesStorageSpy(
            getAllCharactersReturn: [.makeMock()],
            getFavoritesReturn: [:],
            observeFavoritesReturn: .makeEmptyMock()
        ),
        onDetailTap: @escaping (Character) -> Void = { _ in }
    ) -> CharactersViewModel {
        CharactersViewModel(
            dependencies: CharactersViewModel.Dependencies(
                contentConverter: contentConverter,
                charactersService: charactersService,
                storage: storage
            ),
            parameters: CharactersViewModel.Parameters(
                onDetailTap: onDetailTap
            )
        )
    }
}
