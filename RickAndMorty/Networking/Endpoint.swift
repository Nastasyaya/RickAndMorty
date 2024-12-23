//
//  Endpoint.swift
//  RickAndMorty
//
//  Created by Анастасия Кутняхова on 02.12.2024.
//

import Foundation

protocol Endpoint {
    var httpMethod: HTTPMethod { get }
    var queryItems: [URLQueryItem] { get }
}
