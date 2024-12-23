//
//  CharactersViewModel.swift
//  RickAndMorty
//
//  Created by Анастасия Кутняхова on 05.10.2024.
//

import Combine
import Foundation

final class CharactersViewModel: ObservableObject {
    enum State {
        case content(cards: [CharacterListRowViewModel])
        case loading
        case error
    }
    
    struct Dependencies {
        let contentConverter: CharactersContentConverter
        let charactersService: CharactersService
        let storage: FavoritesStorage
    }
    
    struct Parameters {
        let onDetailTap: (_ character: Character) -> Void
    }
    
    @Published private(set) var state: State = .loading
    @Published var inputText: String = ""
    @Published var searchResults: [CharacterListRowViewModel] = []
    @Published var isSearchActive: Bool
    
    private var currentPage = 1
    private var totalPages = 0
    private var isLoading = false
    
    private var cancellables: Set<AnyCancellable> = []
    
    private let dependencies: Dependencies
    private let parameters: Parameters
    private let scheduler: MainScheduler
    
    init(
        isSearchActive: Bool = false,
        dependencies: Dependencies,
        parameters: Parameters,
        scheduler: MainScheduler = .create()
    ) {
        self.isSearchActive = isSearchActive
        self.dependencies = dependencies
        self.parameters = parameters
        self.scheduler = scheduler
        
        observeFavorites()
        observeInputText()
        getCharacters()
    }
}

// MARK: - CancelSearch
extension CharactersViewModel {
    func cancelSearch() {
        self.inputText = ""
        self.isLoading = false
        self.searchResults = []
    }
}

// MARK: - Pagination
extension CharactersViewModel {
    func loadNextPage(character: CharacterListRowViewModel) {
        guard canLoadNextPage(character: character) else { return }
        print("🍄 LOAD NEW PAGE")
        
        isLoading = true
        currentPage += 1
        
        dependencies.charactersService.getCharacters(page: String(currentPage))
            .compactMap { [weak self] response -> State? in
                guard let self = self else { return nil }
                
                let allCharacters = self.dependencies.storage.getAllCharacters() + response.characters
                self.dependencies.storage.send(allCharacters: allCharacters)
                
                let newCards = self.makeContent(from: allCharacters)
                return .content(cards: newCards)
            }
            .receive(on: scheduler)
            .replaceError(with: .error)
            .handleEvents(receiveCompletion: { [weak self] _ in
                self?.isLoading = false
            })
            .assign(to: &$state)
    }
    
    private func canLoadNextPage(character: CharacterListRowViewModel) -> Bool {
        guard case .content = state,
              isLast(character: character),
              !isLoading,
              currentPage < totalPages else { return false }
        
        return true
    }
    
    private func isLast(character: CharacterListRowViewModel) -> Bool {
        guard case let .content(cards) = state else { return false }
        return cards.last?.id == character.id
    }
}

// MARK: - GetCharacters
private extension CharactersViewModel {
    func getCharacters(page: String = "1" ) {
        dependencies.charactersService.getCharacters(page: page)
            .compactMap { [weak self] response in
                self?.totalPages = response.information.pages
                self?.dependencies.storage.send(allCharacters: response.characters)
                return self?.makeInitialContent()
            }
            .map { .content(cards: $0)}
            .replaceError(with: .error)
            .receive(on: scheduler)
            .assign(to: &$state)
    }
}

// MARK: - ObserveFavorites
private extension CharactersViewModel {
    func observeFavorites() {
        dependencies.storage.observeFavorites()
            .compactMap { [weak self] _ in
                self?.makeInitialContent()
            }
            .map { .content(cards: $0) }
            .receive(on: scheduler)
            .assign(to: &$state)
    }
}

// MARK: - ObserveInputText
private extension CharactersViewModel {
    func observeInputText() {
        $inputText
            .dropFirst()
            .debounce(for: .seconds(0.5), scheduler: scheduler)
            .sink { [weak self] text in
                guard let self = self else { return }
                
                if !text.isEmpty {
                    self.searchCharacters(query: text)
                } else {
                    print("😥 TF is empty...")
                    self.searchResults = []
                }
            }
            .store(in: &cancellables)
    }
}

// MARK: - SearchCharacters
private extension CharactersViewModel {
    func searchCharacters(query: String) {
        print("😛 Searching...")
        dependencies.charactersService.searchCharacter(by: query)
            .map { $0.characters }
            .replaceError(with: [])
            .receive(on: scheduler)
            .sink { [weak self] characters in
                guard let self = self else { return }
                self.searchResults = self.makeContent(from: characters)
                print("✔️ Search results updated successfully")
            }
            .store(in: &cancellables)
    }
}

// MARK: - MakeContent
private extension CharactersViewModel {
    func makeContent(from characters: [Character]) -> [CharacterListRowViewModel] {
        dependencies.contentConverter.convert(
            from: characters,
            favoritesIDs: Array(dependencies.storage.getFavorites().keys),
            onDetailTapped: { [weak self] character in
                self?.parameters.onDetailTap(character)
            }
        )
    }
    
    func makeInitialContent() -> [CharacterListRowViewModel] {
        let allCharacters = dependencies.storage.getAllCharacters()
        return makeContent(from: allCharacters)
    }
}
