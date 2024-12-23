//
//  MainView.swift
//  RickAndMorty
//
//  Created by Анастасия Кутняхова on 05.10.2024.
//

import SwiftUI
import UIKit

struct MainView: View {
    enum Tabs {
        case characters
        case favorites
    }
    
    @State private var selectedTab: Tabs = .characters
    @State var isDetailShowing: Bool = false
    
    let manager: NetworkingManager
    let storage: FavoritesStorage
    
    init(
        manager: NetworkingManager,
        storage: FavoritesStorage
    ) {
        self.manager = manager
        self.storage = storage
        
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            makeCharactersFlow()
                .tag(Tabs.characters)
            
            makeFavoritesFlow()
                .tag(Tabs.favorites)
        }
        .overlay(alignment: .bottom) {
            if !isDetailShowing {
                BottomNavBarView(
                    selectedTab: $selectedTab,
                    isDetailShowing: $isDetailShowing
                )
            }
        }
        .ignoresSafeArea(.keyboard)
    }
}

#Preview {
    MainView(
        manager: NetworkingManagerImp.shared,
        storage: FavoritesStorageImp()
    )
}
