//
//  Character.swift
//  RickAndMorty
//
//  Created by Анастасия Кутняхова on 05.10.2024.
//

struct Character: Codable, Hashable {
    let id: Int
    let name: String
    let status: Status
    let species: String
    let type: String
    let gender: String
    let origin, location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

enum Status: String, Codable, Hashable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}
