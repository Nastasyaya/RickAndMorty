@testable import RickAndMorty

final class FavoritesContentConverterSpy: FavoritesContentConverter {
    struct Convert {
        let characters: [Character]
        let onTap: (Character) -> Void
    }
    
    var convertReturn: [CharacterListRowViewModel]
    var convertCalls = [Convert]()
    
    init(convertReturn: [CharacterListRowViewModel]) {
        self.convertReturn = convertReturn
    }
    
    func convert(
        from characters: [Character],
        onTap: @escaping (Character) -> Void
    ) -> [CharacterListRowViewModel] {
        let item = Convert(
            characters: characters,
            onTap: onTap
        )
        convertCalls.append(item)
        return convertReturn
    }
}
