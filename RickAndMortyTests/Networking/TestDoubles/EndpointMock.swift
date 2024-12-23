import Foundation
@testable import RickAndMorty

final class EndpointMock: Endpoint {
    let httpMethod: HTTPMethod
    let queryItems: [URLQueryItem]

    init(httpMethod: HTTPMethod, queryItems: [URLQueryItem]) {
        self.httpMethod = httpMethod
        self.queryItems = queryItems
    }
}
