import Combine

extension AnyPublisher {
    static func makeMock(output: Output) -> Self {
        Just(output)
            .setFailureType(to: Failure.self)
            .eraseToAnyPublisher()
    }

    static func makeMock(error: Failure) -> Self {
        Fail(
            outputType: Output.self,
            failure: error
        )
        .eraseToAnyPublisher()
    }

    static func makeEmptyMock() -> Self {
        Empty().eraseToAnyPublisher()
    }
}
