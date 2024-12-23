//
//  CharactersContentConverter.swift
//  RickAndMorty
//
//  Created by Анастасия Кутняхова on 05.10.2024.
//
import Foundation

protocol CharactersContentConverter {
    func convert(
        from characters: [Character],
        favoritesIDs: [Int],
        onDetailTapped: @escaping (_ character: Character) -> Void
    ) -> [CharacterListRowViewModel]
}

struct CharactersContentConverterImp: CharactersContentConverter {
    func convert(
        from characters: [Character],
        favoritesIDs: [Int],
        onDetailTapped: @escaping (_ character: Character) -> Void
    ) -> [CharacterListRowViewModel] {
        characters.map { character in
            CharacterListRowViewModel(
                id: character.id,
                image: character.image,
                name: character.name,
                status: character.status.rawValue,
                isFavorite: favoritesIDs.contains(where: { character.id == $0 }),
                onTap: {
                    onDetailTapped(character)
                }
            )
        }
    }
}
