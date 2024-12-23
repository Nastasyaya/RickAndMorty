//
//  UserDefaultWrapper.swift
//  RickAndMorty
//
//  Created by Анастасия Кутняхова on 03.12.2024.
//

import Foundation

@propertyWrapper struct UserDefaultWrapper<Value: Codable> {
    private let key: String
    private let defaultValue: Value
    private let storage: UserDefaults
    
    init(key: String, defaultValue: Value, storage: UserDefaults = .standard) {
        self.key = key
        self.defaultValue = defaultValue
        self.storage = storage
        
        storage.synchronize()
    }
    
    var wrappedValue: Value {
        get {
            if
                let data = storage.data(forKey: key),
                let value = try? JSONDecoder().decode(Value.self, from: data)
            {
                return value
            } else {
                return defaultValue
            }
        }
        
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                storage.set(data, forKey: key)
            }
        }
    }
}
