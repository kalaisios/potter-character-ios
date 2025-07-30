//
//  CharacterDetailViewModel.swift
//  PotterCharacters
//
//  Created by Kalaiyarasan on 29/07/25.
//

import Foundation

class CharacterDetailViewModel: ObservableObject {
    @Published var character: PotterCharacter?
    @Published var isLoading: Bool = true
    @Published var error: Error?
    
    private let service: CharacterServiceProtocol
    
    init(service: CharacterServiceProtocol = CharacterServiceManager()) {
        self.service = service
    }

    var errorMessage: String {
        if error != nil {
            AppConstants.Error.unableToFetchData
        } else {
            AppConstants.Error.defaultMessage
        }
    }

    @MainActor
    func fetchCharacterDetails(with index: Int) async {
        do {
            character = try await service.fetchCharacterDetail(index: index)
        } catch {
            self.error = error
        }
        isLoading = false
    }
}
