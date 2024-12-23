@testable import RickAndMorty

final class CharacterDetailContentConverterSpy: CharacterDetailContentConverter {
    struct Convert {
        let character: Character
    }

    var convertReturn: CharacterDetailCardViewModel
    var convert = [Convert]()

    init(convertReturn: CharacterDetailCardViewModel) {
        self.convertReturn = convertReturn
    }

    func convert(
        character: Character
    ) -> CharacterDetailCardViewModel {
        let item = Convert(character: character)
        convert.append(item)
        return convertReturn
    }
}

