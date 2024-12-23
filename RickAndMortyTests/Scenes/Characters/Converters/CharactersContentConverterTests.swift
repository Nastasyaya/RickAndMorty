@testable import RickAndMorty
import XCTest

final class CharactersContentConverterTests: XCTestCase {
    func test_givenCharacters_whenConverted_thenReturnedViewModelsMatch() {
        // Given
        let characters = makeCharacters()
        
        let favoritesIDs = [1]
        let sut = makeSUT()
        var tappedCharacter: Character?
        
        // When
        let result = sut.convert(
            from: characters,
            favoritesIDs: favoritesIDs
        ) { character in
            tappedCharacter = character
        }
        
        // Then
        XCTAssertEqual(result.count, 2)
        
        XCTAssertEqual(result[0].id, 1)
        XCTAssertEqual(result[0].name, "Rick")
        XCTAssertEqual(result[0].isFavorite, true)
        
        XCTAssertEqual(result[1].id, 2)
        XCTAssertEqual(result[1].name, "Morty")
        XCTAssertEqual(result[1].isFavorite, false)
        
        result[0].onTap()
        XCTAssertEqual(tappedCharacter?.id, 1)
    }
}

private extension CharactersContentConverterTests {
    func makeSUT() -> some CharactersContentConverter {
        CharactersContentConverterImp()
    }
}

private extension CharactersContentConverterTests {
    func makeCharacters() -> [Character] {
        return [
            Character.makeMock(
                id: 1,
                name: "Rick",
                status: .alive,
                species: "Human",
                image: "rick_image"
            ),
            Character.makeMock(
                id: 2,
                name: "Morty",
                status: .unknown,
                species: "Human",
                image: "morty_image"
            )
        ]
    }
}
