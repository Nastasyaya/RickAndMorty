//
//  UIApplication.swift
//  RickAndMorty
//
//  Created by Анастасия Кутняхова on 04.10.2024.
//
import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }
}
