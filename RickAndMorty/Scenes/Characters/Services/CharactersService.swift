//
//  CharactersService.swift
//  RickAndMorty
//
//  Created by Анастасия Кутняхова on 02.12.2024.
//
import Combine

protocol CharactersService {
    func getCharacters(page: String) -> AnyPublisher<CharactersResponse, NetworkError>
    func searchCharacter(by name: String) -> AnyPublisher<CharactersResponse, NetworkError>
}

final class CharactersServiceImp: CharactersService {
    private let manager: NetworkingManager
    
    init(manager: NetworkingManager) {
        self.manager = manager
    }
    
    func getCharacters(page: String) -> AnyPublisher<CharactersResponse, NetworkError> {
        manager.run(
            endpoint: CharactersEndpoint.create(
                parameters: CharactersEndpoint.Parameters(page: page, name: nil)
            )
        )
    }
    
    func searchCharacter(by name: String) -> AnyPublisher<CharactersResponse, NetworkError> {
        manager.run(
            endpoint: CharactersEndpoint.create(
                parameters: CharactersEndpoint.Parameters(page: nil, name: name)
            )
        )
    }
}
