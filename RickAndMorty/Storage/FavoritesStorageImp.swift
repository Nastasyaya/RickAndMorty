//
//  FavoritesStorage.swift
//  RickAndMorty
//
//  Created by Анастасия Кутняхова on 07.10.2024.
//

import Combine
import Foundation

protocol FavoritesStorage {
    func getAllCharacters() -> [Character]
    func getFavorites() -> [Int: Character]
    
    func observeFavorites() -> AnyPublisher<[Character], Never>
    
    func remove(by id: Int)
    
    func send(allCharacters: [Character])
    func send(id: Int)
}

final class FavoritesStorageImp: FavoritesStorage {
    @UserDefaultWrapper(key: "allCharacters", defaultValue: [])
    private var allCharacters: [Character]
    
    @UserDefaultWrapper(key: "favorites", defaultValue: [:])
    private var favorites: [Int: Character]
    
    private var favoritesSubject = PassthroughSubject<[Character], Never>()
}

// MARK: - GET
extension FavoritesStorageImp {
    func getAllCharacters() -> [Character] {
        allCharacters
    }
    
    func getFavorites() -> [Int : Character] {
        favorites
    }
}

// MARK: - OBSERVE
extension FavoritesStorageImp {
    func observeFavorites() -> AnyPublisher<[Character], Never> {
        favoritesSubject.eraseToAnyPublisher()
    }
}

// MARK: - REMOVE
extension FavoritesStorageImp {
    func remove(by id: Int) {
        favorites.removeValue(forKey: id)
        print("Favorites after removing: \(favorites)")
        favoritesSubject.send(Array(favorites.values))
    }
}

// MARK: - SEND
extension FavoritesStorageImp {
    func send(allCharacters: [Character]) {
        self.allCharacters = allCharacters
    }
    
    func send(id: Int) {
        guard let character = allCharacters.first(where: { $0.id == id }) else {
            return
        }
        
        favorites.updateValue(character, forKey: id)
        print("Favorites after adding: \(favorites)")
        favoritesSubject.send(Array(favorites.values))
    }
}
