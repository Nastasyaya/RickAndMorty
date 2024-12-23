//
//  DetailCharacterView.swift
//  RickAndMorty
//
//  Created by Анастасия Кутняхова on 09.10.2024.
//

import SwiftUI

struct CustomNavigationTitle: View {
    let label: String
    let action: () -> Void
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    action()
                } label: {
                    Image(systemName: "chevron.left")
                        .frame(width: 24, height: 24)
                    Text(label)
                        .font(.custom("Inter", size: 16))
                }
                
                Spacer()
            }
            .frame(maxHeight: 44)
            .padding(.horizontal)
            .background(.backgroundsPrimary)
        }
    }
}

#Preview {
    CustomNavigationTitle(label: "Favorites", action: {})
}
