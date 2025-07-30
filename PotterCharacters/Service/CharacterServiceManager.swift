//
//  CharacterServiceManager.swift
//  PotterCharacters
//
//  Created by Kalaiyarasan on 28/07/25.
//

import Foundation

protocol CharacterServiceProtocol {
    func fetchCharacters() async throws -> [PotterCharacter]
    func fetchCharacterDetail(index: Int) async throws -> PotterCharacter?
}

class CharacterServiceManager: CharacterServiceProtocol {
    private let networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }

    func fetchCharacters() async throws -> [PotterCharacter] {
        guard let url = URL(string: AppConstants.baseURL + AppConstants.Endpoints.characters) else {
            throw URLError(.badURL)
        }

        return try await networkService.request(url, responseType: [PotterCharacter].self)
    }

    func fetchCharacterDetail(index: Int) async throws -> PotterCharacter? {
        let path = String(format: AppConstants.Endpoints.charactersWithIndex, "\(index)")
        guard let url = URL(string: AppConstants.baseURL + path) else {
            throw URLError(.badURL)
        }

        return try await networkService.request(url, responseType: PotterCharacter.self)
    }
}
