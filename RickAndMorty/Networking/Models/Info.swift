//
//  Info.swift
//  RickAndMorty
//
//  Created by Анастасия Кутняхова on 05.10.2024.
//

struct Info: Decodable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}
