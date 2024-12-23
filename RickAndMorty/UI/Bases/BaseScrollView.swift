//
//  BaseScrollView.swift
//  RickAndMorty
//
//  Created by Анастасия Кутняхова on 05.12.2024.
//

import SwiftUI

struct BaseScrollView<Content: View>: View {
    
    private let spacing: CGFloat
    private let content: () -> Content
    
    init(
        spacing: CGFloat = 16,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.spacing = spacing
        self.content = content
    }
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack(spacing: spacing) {
                    content()
                }
                .padding(.horizontal)
            }
        }
    }
}
