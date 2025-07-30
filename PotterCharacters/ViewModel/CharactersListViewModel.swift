//
//  CharactersListViewModel.swift
//  PotterCharacters
//
//  Created by Kalaiyarasan on 28/07/25.
//

import Foundation

class CharactersListViewModel: ObservableObject {
    @Published var characters: [PotterCharacter]?
    @Published var isLoading: Bool = true
    @Published var error: Error?

    private let service: CharacterServiceProtocol

    init(service: CharacterServiceProtocol = CharacterServiceManager()) {
        self.service = service
    }

    @MainActor
    func loadCharacters() async {
        do {
            characters = try await service.fetchCharacters()
        } catch {
            self.error = error
        }
        isLoading = false
    }
}
