import Combine
@testable import RickAndMorty
import XCTest

final class CharactersServiceTests: XCTestCase {
    func test_givenGetCharactersRequest_whenResponseReceived_thenResponseMatched() {
        // Given
        let manager = NetworkingManagerSpy(
            runEndpointReturn: .makeMock(
                output: CharactersResponse(
                    information: .makeMock(),
                    characters: [.makeMock()]
                )
            ),
            runFromURLReturn: .makeEmptyMock()
        )
        let sut = makeSUT(manager: manager)

        // When
        let cancellable = sut.getCharacters(page: "page")
            .sink(
                receiveCompletion: { output in
                    switch output {
                    case .finished:
                        print("Response recieved successfully")
                    case let .failure(error):
                        XCTFail("Failed to recieved with error: \(error)")
                    }
                },
                receiveValue: { response in
                    // Then
                    XCTAssertEqual(response.characters.count, 1)
                }
            )
        cancellable.cancel()
    }

    func test_givenGetCharactersRequest_whenErrorReceived_thenErrorMatched() {
        // Given
        let manager = NetworkingManagerSpy<CharactersResponse>(
            runEndpointReturn: .makeMock(error: .unknown),
            runFromURLReturn: .makeEmptyMock()
        )
        let sut = makeSUT(manager: manager)

        // When
        let cancellable = sut.getCharacters(page: "page")
            .sink(
                receiveCompletion: { output in
                    switch output {
                    case .finished:
                        print("Response recieved successfully")
                    case let .failure(error):
                        // Then
                        guard case .unknown = error else {
                            return XCTFail("Wrong error")
                        }
                    }
                },
                receiveValue: { response in
                    XCTAssertEqual(response.characters.count, 1)
                }
            )
        cancellable.cancel()
    }
    
    func test_givenSearchCharactersRequest_whenResponseReceived_thenResponseMatched() {
        // Given
        let manager = NetworkingManagerSpy(
            runEndpointReturn: .makeMock(
                output: CharactersResponse(
                    information: .makeMock(),
                    characters: [.makeMock()]
                )
            ),
            runFromURLReturn: .makeEmptyMock()
        )
        let sut = makeSUT(manager: manager)

        // When
        let cancellable = sut.searchCharacter(by: "1")
            .sink(
                receiveCompletion: { output in
                    switch output {
                    case .finished:
                        print("Response recieved successfully")
                    case let .failure(error):
                        XCTFail("Failed to recieved with error: \(error)")
                    }
                },
                receiveValue: { response in
                    // Then
                    XCTAssertEqual(response.characters.count, 1)
                }
            )
        cancellable.cancel()
    }

    func test_givenSearchCharactersRequest_whenErrorReceived_thenErrorMatched() {
        // Given
        let manager = NetworkingManagerSpy<CharactersResponse>(
            runEndpointReturn: .makeMock(error: .unknown),
            runFromURLReturn: .makeEmptyMock()
        )
        let sut = makeSUT(manager: manager)

        // When
        let cancellable = sut.searchCharacter(by: "1")
            .sink(
                receiveCompletion: { output in
                    switch output {
                    case .finished:
                        print("Response recieved successfully")
                    case let .failure(error):
                        // Then
                        guard case .unknown = error else {
                            return XCTFail("Wrong error")
                        }
                    }
                },
                receiveValue: { response in
                    XCTAssertEqual(response.characters.count, 1)
                }
            )
        cancellable.cancel()
    }
}

private extension CharactersServiceTests {
    func makeSUT(
        manager: NetworkingManager = NetworkingManagerSpy<CharactersResponse>(
            runEndpointReturn: .makeEmptyMock(),
            runFromURLReturn: .makeEmptyMock()
        )
    ) -> some CharactersService {
        CharactersServiceImp(manager: manager)
    }
}
