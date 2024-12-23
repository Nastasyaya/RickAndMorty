//
//  SearchBar.swift
//  RickAndMorty
//
//  Created by Анастасия Кутняхова on 04.10.2024.
//

import SwiftUI

struct SearchBar: View {
    @Binding var inputText: String
    @FocusState var isFocused: Bool
    @State private var showCancelButton: Bool = false
    
    let onCancel: () -> Void
    
    var body: some View {
        HStack {
            content
            
            if isFocused {
                cancelButton
            }
        }
        .padding(.top, 1)
        .padding(.bottom, 8)
    }
    
    private var content: some View {
        HStack {
            Image("search")
                .frame(width: 24, height: 24)
            
            TextField("Search character", text: $inputText)
                .foregroundStyle(.accent)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .focused($isFocused)
                .overlay(
                    Image(systemName: "xmark.circle")
                        .frame(width: 16, height: 16)
                        .foregroundStyle(.iconsPrimary)
                        .opacity(inputText.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            inputText = ""
                        }
                    ,alignment: .trailing
                )
        }
        .font(.custom("Inter", size: 16))
        .padding(.horizontal, 4)
        .padding(4)
        .background {
            RoundedRectangle(cornerRadius: 16)
                .fill(.backgroundsSecondary)
        }
        .frame(height: 32)
    }
    
    private var cancelButton: some View {
        Button("Cancel") {
            UIApplication.shared.endEditing()
            inputText = ""
            
            withAnimation {
                onCancel()
            }
        }
        .transition(.move(edge: .trailing))
        .foregroundStyle(.iconsPrimary)
        .padding(.horizontal, 8)
    }
}

#Preview {
    @Previewable @State var text: String = ""
    
    SearchBar(inputText: $text, onCancel: {})
        .preferredColorScheme(.light)
    
    Spacer()
}
