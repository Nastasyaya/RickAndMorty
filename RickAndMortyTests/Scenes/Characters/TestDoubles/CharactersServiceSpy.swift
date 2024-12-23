import Combine
@testable import RickAndMorty

final class CharactersServiceSpy: CharactersService {
    struct GetCharactersCall {
        let page: String
    }
    
    struct SearchCharacterCall {
        let name: String
    }
    
    var getCharactersReturn: AnyPublisher<CharactersResponse, NetworkError>
    var searchCharacterReturn: AnyPublisher<CharactersResponse, NetworkError>
    
    private(set) var getCharactersCalls = [GetCharactersCall]()
    private(set) var searchCharacterCalls = [SearchCharacterCall]()
    
    init(
        getCharactersReturn: AnyPublisher<CharactersResponse, NetworkError>,
        searchCharacterReturn: AnyPublisher<CharactersResponse, NetworkError>
    ) {
        self.getCharactersReturn = getCharactersReturn
        self.searchCharacterReturn = searchCharacterReturn
    }
    
    func getCharacters(
        page: String
    ) -> AnyPublisher<CharactersResponse, NetworkError> {
        let call = GetCharactersCall(page: page)
        getCharactersCalls.append(call)
        return getCharactersReturn
    }
    
    func searchCharacter(
        by name: String
    ) -> AnyPublisher<CharactersResponse, NetworkError> {
        let call = SearchCharacterCall(name: name)
        searchCharacterCalls.append(call)
        return searchCharacterReturn
    }
}

