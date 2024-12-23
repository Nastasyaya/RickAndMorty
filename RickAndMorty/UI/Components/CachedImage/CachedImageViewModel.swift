//
//  CachedImageViewModel.swift
//  RickAndMorty
//
//  Created by Анастасия Кутняхова on 05.10.2024.
//

import Combine
import UIKit

final class CachedImageViewModel: ObservableObject {
    enum State {
        case image(UIImage)
        case loading
    }

    @Published private(set) var state: State = .loading

    private let service: CachedImageService
    private let scheduler: MainScheduler

    init(
        service: CachedImageService,
        url: String,
        scheduler: MainScheduler = .create()
    ) {
        self.service = service
        self.scheduler = scheduler
        
        fetchImage(url: url)
    }

    func fetchImage(url: String) {
        service.getImage(from: url)
            .map { .image($0) }
            .replaceError(with: .loading)
            .receive(on: scheduler)
            .assign(to: &$state)
    }
}
