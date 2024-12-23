@testable import RickAndMorty

final class CharactersContentConverterSpy: CharactersContentConverter {
    struct Convert {
        let characters: [Character]
        let favoritesIDs: [Int]
        let onDetailTapped: (Character) -> Void
    }
    
    var convertReturn: [CharacterListRowViewModel]
    var convertCalls = [Convert]()
    
    init(convertReturn: [CharacterListRowViewModel]) {
        self.convertReturn = convertReturn
    }
    
    func convert(
        from characters: [Character],
        favoritesIDs: [Int],
        onDetailTapped: @escaping (Character) -> Void
    ) -> [CharacterListRowViewModel] {
        let item = Convert(
            characters: characters,
            favoritesIDs: favoritesIDs,
            onDetailTapped: onDetailTapped
        )
        convertCalls.append(item)
        return convertReturn
    }
}
