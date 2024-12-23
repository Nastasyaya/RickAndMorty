//
//  CachedImageService.swift
//  RickAndMorty
//
//  Created by Анастасия Кутняхова on 02.12.2024.
//

import Combine
import SwiftUI

protocol CachedImageService {
    func getImage(from url: String) -> AnyPublisher<UIImage, NetworkError>
}

final class CachedImageServiceImp: CachedImageService {
    private let manager: NetworkingManager
    
    init(manager: NetworkingManager) {
        self.manager = manager
    }
    
    func getImage(from url: String) -> AnyPublisher<UIImage, NetworkError> {
        manager.run(from: url)
    }
}
