@testable import RickAndMorty

extension CharactersEndpoint.Parameters {
    static func makeMock(
        page: String? = nil,
        name: String? = nil
    ) -> Self {
        CharactersEndpoint.Parameters(
            page: page,
            name: name
        )
    }
}
