//
//  CharacterListRowViewModel.swift
//  RickAndMorty
//
//  Created by Анастасия Кутняхова on 02.12.2024.
//

struct CharacterListRowViewModel: Identifiable, Equatable {
    let id: Int
    let image: String
    let name: String
    let status: String
    let isFavorite: Bool
    let onTap: () -> Void
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}
