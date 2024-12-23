//
//  NetworkError.swift
//  RickAndMorty
//
//  Created by Анастасия Кутняхова on 05.10.2024.
//
import Foundation

enum NetworkError: Error {
    case network(URLError.Code)
    case decoding(Error)
    case unknown
}
