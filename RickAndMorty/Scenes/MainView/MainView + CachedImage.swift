//
//  MainView + CachedImage.swift
//  RickAndMorty
//
//  Created by Анастасия Кутняхова on 22.12.2024.
//

import Foundation

extension MainView {
    func makeCachedImageView(url: String, frame: CGFloat) -> CachedImageView {
        CachedImageView(
            viewModel: CachedImageViewModel(
                service: makeCachedImageService(),
                url: url
            ),
            frame: frame
        )
    }
}

private extension MainView {
    func makeCachedImageService() -> some CachedImageService {
        CachedImageServiceImp(manager: manager)
    }
}
