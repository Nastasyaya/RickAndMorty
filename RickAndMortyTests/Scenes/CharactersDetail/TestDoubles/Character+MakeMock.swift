@testable import RickAndMorty

extension Character {
    static func makeMock(
        id: Int = 1,
        name: String = "name",
        status: Status = .unknown,
        species: String = "species",
        type: String = "type",
        gender: String = "gender",
        origin: Location = .makeMock(name: "origin"),
        location: Location = .makeMock(name: "location"),
        image: String = "search",
        episode: [String] = [],
        url: String = "url",
        created: String = "created"
    ) -> Self {
        Character(
            id: id,
            name: name,
            status: status,
            species: species,
            type: type,
            gender: gender,
            origin: origin,
            location: location,
            image: image,
            episode: episode,
            url: url,
            created: created
        )
    }
}
