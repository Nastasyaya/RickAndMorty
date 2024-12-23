//
//  CustomNavigationBarView.swift
//  RickAndMorty
//
//  Created by Анастасия Кутняхова on 05.10.2024.
//

import SwiftUI

struct CustomNavigationBarView: View {
    let title: String
    
    var body: some View {
        ZStack {
            HStack(alignment: .top) {
                Text(title)
                    .font(.custom("Inter", size: 28))
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding(EdgeInsets(top: 8, leading: 16, bottom: 0, trailing: 0))
                
                Spacer()
            }
            .background {
                Color.backgroundsPrimary.ignoresSafeArea(edges: .top)
            }
            Spacer()
        }
    }
}

#Preview {
    CustomNavigationBarView(title: "Characters")
}
