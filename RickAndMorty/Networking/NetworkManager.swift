//
//  NetworkManager.swift
//  RickAndMorty
//
//  Created by Анастасия Кутняхова on 05.10.2024.
//

import Combine
import SwiftUI

protocol NetworkingManager {
    func run<R: Decodable>(endpoint: Endpoint) -> AnyPublisher<R, NetworkError>
    func run(from url: String) -> AnyPublisher<UIImage, NetworkError>
}

final class NetworkingManagerImp: NetworkingManager {
    final class ImageCache {
        private var cache = NSCache<NSString, UIImage>()
        
        func getImage(forKey key: String) -> UIImage? {
            return cache.object(forKey: NSString(string: key))
        }
        
        func setImage(_ image: UIImage, forKey key: String) {
            cache.setObject(image, forKey: NSString(string: key))
        }
    }
    
    static let shared = NetworkingManagerImp()
    private let cache = ImageCache()
    
    private init() {}
    
    // MARK: - FETCH IMAGE FUNC
    func run(from url: String) -> AnyPublisher<UIImage, NetworkError> {
        guard let url = URL(string: url) else {
            return Fail(error: .network(.badURL))
                .eraseToAnyPublisher()
        }
        
        if let cachedImage = cache.getImage(forKey: url.absoluteString) {
            return Just(cachedImage)
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response in
                guard let image = UIImage(data: data) else {
                    throw NetworkError.decoding(NSError(domain: "Invalid image data", code: -1, userInfo: nil))
                }
                return image
            }
            .mapError { error -> NetworkError in
                if let error = error as? URLError {
                    return .network(error.code)
                } else if let error = error as? DecodingError {
                    return .decoding(error)
                } else {
                    return .unknown
                }
            }
            .handleEvents(receiveOutput: { [weak self] image in
                self?.cache.setImage(image, forKey: url.absoluteString)
            })
            .eraseToAnyPublisher()
    }
    
    // MARK: - FETCH CHARACTERS FUNC
    func run<R: Decodable>(endpoint: Endpoint) -> AnyPublisher<R, NetworkError> {
        guard let request = makeURLRequest(from: endpoint) else {
            return Fail(error: .network(.badURL))
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200
                else {
                    throw NetworkError.network(.badServerResponse)
                }
                print(response.statusCode)
                print(response.url?.absoluteString ?? "🐦‍🔥 Incorrect url")
                print(data.prettyPrintedJSONString ?? "🔥 Incorrect data")
                
                return data
            }
            .decode(type: R.self, decoder: JSONDecoder())
            .mapError { error -> NetworkError in
                if let error = error as? URLError {
                    print(error)
                    return .network(error.code)
                } else if let error = error as? DecodingError {
                    print(error)
                    return .decoding(error)
                } else {
                    return .unknown
                }
            }
            .eraseToAnyPublisher()
    }
    
    // MARK: - MAKE REQUEST
    private func makeURLRequest(from endpoint: Endpoint) -> URLRequest? {
        guard let url = makeURL(from: endpoint) else {
            return nil
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = endpoint.httpMethod.rawValue
        request.timeoutInterval = 10
        
        return request
    }
    
    // MARK: - MAKE URL
    private func makeURL(from endpoint: Endpoint) -> URL? {
        var components = URLComponents()
        
        components.scheme = "https"
        components.host = "rickandmortyapi.com"
        components.path = "/api/character"
        components.queryItems = endpoint.queryItems
        
        return components.url
    }
}
