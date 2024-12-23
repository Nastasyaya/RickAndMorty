//
//  CharacterDetailContentConverter.swift
//  RickAndMorty
//
//  Created by Анастасия Кутняхова on 04.12.2024.
//

protocol CharacterDetailContentConverter {
    func convert(
        character: Character
    ) -> CharacterDetailCardViewModel
}

struct CharactersDetailContentConverterImp: CharacterDetailContentConverter {
    func convert(
        character: Character
    ) -> CharacterDetailCardViewModel {
        CharacterDetailCardViewModel(
            id: character.id,
            name: character.name,
            status: character.status.rawValue,
            image: character.image,
            species: character.species,
            type: character.type.isEmpty ? "-" : character.type,
            gender: character.gender,
            origin: character.origin.name,
            location: character.location.name
        )
    }
}
