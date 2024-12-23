@testable import RickAndMorty

extension CharacterDetailCardViewModel {
    static func makeMock(
        id: Int = 1,
        name: String = "name",
        status: String = "status",
        image: String = "image",
        species: String = "species",
        type: String = "type",
        gender: String = "gender",
        origin: String = "origin",
        location: String = "location"
    ) -> Self {
        CharacterDetailCardViewModel(
            id: id,
            name: name,
            status: status,
            image: image,
            species: species,
            type: type,
            gender: gender,
            origin: origin,
            location: location
        )
    }
}
