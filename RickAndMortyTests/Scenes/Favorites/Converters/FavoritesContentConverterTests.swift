@testable import RickAndMorty
import XCTest

final class FavoritesContentConverterTests: XCTestCase {
    func test_givenInitialized_whenContentConverted_thenContentMatched() {
        // Given
        let sut = makeSUT()
        
        // When
        let content = sut.convert(
            from: [.makeMock()],
            onTap: { _ in }
        )
        
        // Then
        XCTAssertEqual(content.count, 1)
        XCTAssertEqual(content.first?.image, "search")
        XCTAssertEqual(content.first?.id, 1)
        XCTAssertEqual(content.first?.name, "name")
        XCTAssertEqual(content.first?.status, "unknown")
        XCTAssertTrue(content.first?.isFavorite ?? false)
    }
    
//    func test_whenCharacterTapped_thenActionExecuted() {
//        // Given
//        var isActionExecuted = false
//       
//        let sut = makeSUT()
//        let service = CachedImageServiceSpy(
//            getImageReturn: .makeMock(output: .search)
//        )
//        let onTap: (Character) -> Void = { tappedCharacter in
//            if tappedCharacter.id == 1 {
//                isActionExecuted = true
//            }
//        }
//        
//        // When
//        let content = sut.convert(
//            from: [.makeMock()],
//            service: service,
//            onTap: onTap
//        )
//        
//        // Then
//        content.first?.onTap()
//        XCTAssertTrue(isActionExecuted)
//    }
}

private extension FavoritesContentConverterTests {
    func makeSUT() -> some FavoritesContentConverter {
        FavoritesContentConverterImp()
    }
}
