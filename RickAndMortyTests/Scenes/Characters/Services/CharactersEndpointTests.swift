import Foundation
@testable import RickAndMorty
import XCTest

final class CharactersEndpointTests: XCTestCase {
    func test_givenInitialized_thenEndpointParametersMatched() {
        let name = "Rick"
        let page = "1"
        let sut = makeSUT(parameters: .makeMock(page: page, name: name))

        XCTAssertEqual(sut.httpMethod, .get)
        XCTAssertEqual(sut.queryItems.count, 2)
        XCTAssertEqual(sut.queryItems[0].name, "page")
        XCTAssertEqual(sut.queryItems[0].value, page)
        XCTAssertEqual(sut.queryItems[1].name, "name")
        XCTAssertEqual(sut.queryItems[1].value, name)
    }
}

private extension CharactersEndpointTests {
    func makeSUT(parameters: CharactersEndpoint.Parameters) -> some Endpoint {
        CharactersEndpoint(
            parameters: parameters
        )
    }
}
