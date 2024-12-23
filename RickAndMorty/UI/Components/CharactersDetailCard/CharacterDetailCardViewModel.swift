//
//  CharacterDetailCardViewModel.swift
//  RickAndMorty
//
//  Created by Анастасия Кутняхова on 06.10.2024.
//

import SwiftUI

struct CharacterDetailCardViewModel: Identifiable, Equatable {
    let id: Int
    let name: String
    let status: String
    let image: String
    let species: String
    let type: String
    let gender: String
    let origin: String
    let location: String

    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}
