//
//  Schedulers.swift
//  RickAndMorty
//
//  Created by Анастасия Кутняхова on 22.12.2024.
//

import CombineSchedulers
import Foundation

typealias MainScheduler = AnySchedulerOf<DispatchQueue>
typealias TestScheduler = TestSchedulerOf<DispatchQueue>

extension MainScheduler {
    static func create() -> MainScheduler {
        DispatchQueue.main.eraseToAnyScheduler()
    }
}

extension TestScheduler {
    var asMainScheduler: MainScheduler {
        self.eraseToAnyScheduler()
    }

    static func create() -> TestSchedulerOf<DispatchQueue> {
        DispatchQueue.test
    }
}
