//
//  RickAndMortyApp.swift
//  RickAndMorty
//
//  Created by Анастасия Кутняхова on 04.10.2024.
//

import SwiftUI

@main
struct RickAndMortyApp: App {
    private let manager = NetworkingManagerImp.shared
    private let storage = FavoritesStorageImp()
    
    var body: some Scene {
        WindowGroup {
            MainView(manager: manager, storage: storage)
        }
    }
}
