import Combine
@testable import RickAndMorty

final class FavoritesStorageSpy: FavoritesStorage {
    struct Remove {
        let id: Int
    }

    struct SendAllCharacters {
        let allCharacters: [Character]
    }

    struct SendID {
        let id: Int
    }

    var getAllCharactersReturn: [Character]
    var getFavoritesReturn: [Int: Character]
    var observeFavoritesReturn: AnyPublisher<[Character], Never>
    var getAllCharactersCount = 0
    var getFavoritesCount = 0
    var observeFavoritesCount = 0
    var remove = [Remove]()
    var sendAllCharacters = [SendAllCharacters]()
    var sendID = [SendID]()
    
    init(
        getAllCharactersReturn: [Character],
        getFavoritesReturn: [Int: Character],
        observeFavoritesReturn: AnyPublisher<[Character], Never>
    ) {
        self.getAllCharactersReturn = getAllCharactersReturn
        self.getFavoritesReturn = getFavoritesReturn
        self.observeFavoritesReturn = observeFavoritesReturn
    }

    func getAllCharacters() -> [Character] {
        getAllCharactersCount += 1
        return getAllCharactersReturn
    }

    func getFavorites() -> [Int : Character] {
        getFavoritesCount += 1
        return getFavoritesReturn
    }

    func observeFavorites() -> AnyPublisher<[Character], Never> {
        observeFavoritesCount += 1
        return observeFavoritesReturn
    }

    func remove(by id: Int) {
        let item = Remove(id: id)
        remove.append(item)
    }

    func send(allCharacters: [Character]) {
        let item = SendAllCharacters(allCharacters: allCharacters)
        sendAllCharacters.append(item)
    }

    func send(id: Int) {
        let item = SendID(id: id)
        sendID.append(item)
    }
}
