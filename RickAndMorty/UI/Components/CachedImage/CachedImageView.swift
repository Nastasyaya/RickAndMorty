//
//  CachedImageView.swift
//  RickAndMorty
//
//  Created by Анастасия Кутняхова on 05.10.2024.
//

import SwiftUI

struct CachedImageView: View {
    @StateObject var viewModel: CachedImageViewModel
    
    let frame: CGFloat
    
    var body: some View {
        switch viewModel.state {
        case .image(let uiImage):
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFill()
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .frame(width: frame, height: frame)
            
        case .loading:
            Color.foregroundsSecondary
                .blinking()
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .frame(width: frame, height: frame)
        }
    }
}
