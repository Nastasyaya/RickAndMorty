//
//  BottomNavBarView.swift
//  RickAndMorty
//
//  Created by Анастасия Кутняхова on 04.10.2024.
//

import SwiftUI

struct BottomNavBarView: View {
    @State private var favoritesColor: Color = Color.iconsTertiary
    @State private var charactersColor: Color = Color.iconsSecondary
    
    @State private var yOffset: CGFloat = 100
    @Binding var selectedTab: MainView.Tabs
    @Binding var isDetailShowing: Bool
    
    var body: some View {
        HStack(spacing: 32) {
            charactersTabButton

            favoritesTabButton
        }
        .frame(width: 182, height: 62)
        .background {
            RoundedRectangle(cornerRadius: 31)
                .fill(.backgroundsBottomNavigation)
                .shadow(radius: 16, y: 2)
        }
        .offset(y: yOffset)
        .onAppear {
            withAnimation(.bouncy) {
                yOffset = 0.5
            }
            updateTabColors()
        }
        .onChange(of: selectedTab) {
            updateTabColors()
        }
    }
    
    // MARK: - CharactersTabButton
    private var charactersTabButton: some View {
        Button {
            selectedTab = .characters
        } label: {
            Image("charactersTabIcon")
                .renderingMode(.template)
                .tint(charactersColor)
        }
    }
    
    // MARK: - FavoritesTabButton
    private var favoritesTabButton: some View {
        Button {
            selectedTab = .favorites
        } label: {
            Image("favoritesTabIcon")
                .renderingMode(.template)
                .tint(favoritesColor)
        }
    }
    
    // MARK: - UpdateTabColors
    private func updateTabColors() {
        switch selectedTab {
        case .characters:
            charactersColor = Color.iconsTertiary
            favoritesColor = Color.iconsSecondary
        case .favorites:
            favoritesColor = Color.iconsTertiary
            charactersColor = Color.iconsSecondary
        }
    }
}

#Preview {
    BottomNavBarView(
        selectedTab: .constant(.favorites),
        isDetailShowing: .constant(true)
    )
}
