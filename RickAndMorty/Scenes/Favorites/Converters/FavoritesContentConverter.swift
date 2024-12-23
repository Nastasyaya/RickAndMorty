//
//  FavoritesContentConverter.swift
//  RickAndMorty
//
//  Created by Анастасия Кутняхова on 04.12.2024.
//

protocol FavoritesContentConverter {
    func convert(
        from characters: [Character],
        onTap: @escaping (_ character: Character) -> Void
    ) -> [CharacterListRowViewModel]
}

struct FavoritesContentConverterImp: FavoritesContentConverter {
    func convert(
        from characters: [Character],
        onTap: @escaping (Character) -> Void
    ) -> [CharacterListRowViewModel] {
        characters.map { character in
            CharacterListRowViewModel(
                id: character.id,
                image: character.image,
                name: character.name,
                status: character.status.rawValue,
                isFavorite: true,
                onTap: {
                    onTap(character)
                }
            )
        }
    }
}
