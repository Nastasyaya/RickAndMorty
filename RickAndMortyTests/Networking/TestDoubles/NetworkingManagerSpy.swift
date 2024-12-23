import Combine
@testable import RickAndMorty
import UIKit

final class NetworkingManagerSpy<T: Decodable>: NetworkingManager {
    struct RunEndpoint {
        let endpoint: Endpoint
    }

    struct RunFromURL {
        let url: String
    }

    var runEndpointReturn: AnyPublisher<T, NetworkError>
    var runFromURLReturn: AnyPublisher<UIImage, NetworkError>
    var runEndpoint = [RunEndpoint]()
    var runFromURL = [RunFromURL]()

    init(
        runEndpointReturn: AnyPublisher<T, NetworkError>,
        runFromURLReturn: AnyPublisher<UIImage, NetworkError>
    ) {
        self.runEndpointReturn = runEndpointReturn
        self.runFromURLReturn = runFromURLReturn
    }

    func run<R: Decodable>(endpoint: Endpoint) -> AnyPublisher<R, NetworkError> {
        let item = RunEndpoint(endpoint: endpoint)
        runEndpoint.append(item)
        return runEndpointReturn as? AnyPublisher<R, NetworkError> ?? Fail(
            error: NetworkError.unknown
        )
        .eraseToAnyPublisher()
    }

    func run(from url: String) -> AnyPublisher<UIImage, NetworkError> {
        let item = RunFromURL(url: url)
        runFromURL.append(item)
        return runFromURLReturn
    }
}
