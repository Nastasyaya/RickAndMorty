@testable import RickAndMorty

extension CharactersResponse {
    static func makeMock() -> Self {
        CharactersResponse(
            information: .makeMock(),
            characters: [.makeMock()]
        )
    }
}
