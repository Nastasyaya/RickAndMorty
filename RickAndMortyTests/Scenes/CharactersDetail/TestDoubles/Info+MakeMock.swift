@testable import RickAndMorty

extension Info {
    static func makeMock(
        count: Int = 1,
        pages: Int = 1,
        next: String? = nil,
        prev: String? = nil
    ) -> Self {
        Info(
            count: count,
            pages: pages,
            next: next,
            prev: prev
        )
    }
}
