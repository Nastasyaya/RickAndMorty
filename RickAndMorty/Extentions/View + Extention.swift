//
//  View + Extention.swift
//  RickAndMorty
//
//  Created by Анастасия Кутняхова on 09.12.2024.
//
import SwiftUI

extension View {
    func centerVertically() -> some View {
        VStack {
            Spacer()
            self
            Spacer()
        }
    }
    
    @ViewBuilder
    func isVisible(_ value: Bool) -> some View {
        switch value {
        case true: hidden()
        case false: self
        }
    }
}
