@testable import RickAndMorty

extension Location {
    static func makeMock(
        name: String = "name",
        url: String = "url"
    ) -> Self {
        Location(
            name: name,
            url: url
        )
    }
}
