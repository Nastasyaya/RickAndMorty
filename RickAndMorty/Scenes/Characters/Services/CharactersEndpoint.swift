//
//  CharactersEndpoint.swift
//  RickAndMorty
//
//  Created by Анастасия Кутняхова on 02.12.2024.
//
import Foundation

struct CharactersEndpoint: Endpoint {
    struct Parameters {
        let page: String?
        let name: String?
    }
    
    let httpMethod: HTTPMethod = .get
    let queryItems: [URLQueryItem]
    
    init(parameters: Parameters) {
        self.queryItems = [
            parameters.page.map { URLQueryItem(name: "page", value: $0) },
            parameters.name.map { URLQueryItem(name: "name", value: $0) }
        ]
        .compactMap { $0 }
    }
    
    static func create(parameters: Parameters) -> Self {
        CharactersEndpoint(parameters: parameters)
    }
}
