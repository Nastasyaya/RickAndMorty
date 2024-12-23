@testable import RickAndMorty
import XCTest

final class CharacterDetailContentConverterTests: XCTestCase {
    func test_givenInitialized_whenContentConverted_thenContentMatched() {
        // Given
        let sut = makeSUT()

        // When
        let content = sut.convert(
            character: .makeMock()
        )

        // Then
        XCTAssertEqual(content.image, "search")
        XCTAssertEqual(content.id, 1)
        XCTAssertEqual(content.name, "name")
        XCTAssertEqual(content.status, "unknown")
        XCTAssertEqual(content.species, "species")
        XCTAssertEqual(content.type, "type")
        XCTAssertEqual(content.gender, "gender")
        XCTAssertEqual(content.origin, "origin")
        XCTAssertEqual(content.location, "location")
    }

    func test_givenTypeIsEmpty_whenContentConverted_thenContentTypeMatched() {
        // Given
        let type = ""
        let sut = makeSUT()

        // When
        let content = sut.convert(character: .makeMock(type: type))

        // Then
        XCTAssertEqual(content.type, "-")
    }
}

private extension CharacterDetailContentConverterTests {
    func makeSUT() -> some CharacterDetailContentConverter {
        CharactersDetailContentConverterImp()
    }
}
