@testable import RickAndMorty

extension CharacterListRowViewModel {
    static func makeMock(
        id: Int = 1,
        image: String = "image",
        name: String = "name",
        status: String = "status",
        isFavorite: Bool = true,
        onTap: @escaping () -> Void = {}
    ) -> Self {
            CharacterListRowViewModel(
                id: id,
                image: image,
                name: name,
                status: status,
                isFavorite: isFavorite,
                onTap: onTap
            )
        }
}
