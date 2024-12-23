//
//  CharactersResponse.swift
//  RickAndMorty
//
//  Created by Анастасия Кутняхова on 05.10.2024.
//

struct CharactersResponse: Decodable {
    let information: Info
    let characters: [Character]
    
    enum CodingKeys: String, CodingKey {
        case information = "info"
        case characters = "results"
    }
}
