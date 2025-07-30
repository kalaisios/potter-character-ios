//
//  CharacterListViewModelTests.swift
//  PotterCharactersTests
//
//  Created by Kalaiyarasan on 30/07/25.
//

import XCTest
@testable import PotterCharacters

enum MockError: Error {
    case defaultError
}

final class CharacterListViewModelTests: XCTestCase {
    var viewModel: CharactersListViewModel!
    var mockService: MockCharactersService!

    override func setUp() {
        super.setUp()
        mockService = MockCharactersService()
        viewModel = CharactersListViewModel(service: mockService)
    }
    
    override func tearDown() {
        viewModel = nil
        mockService = nil
        super.tearDown()
    }

    func testErrorMessage() {
        // Check default error message
        XCTAssertEqual(viewModel.errorMessage, AppConstants.Error.defaultMessage)

        // When there is an error
        viewModel.characters = nil
        viewModel.error = URLError(.badServerResponse)
        XCTAssertEqual(viewModel.errorMessage, AppConstants.Error.unableToFetchData)

        // When the characters list is empty
        viewModel.characters = []
        viewModel.error = nil
        XCTAssertEqual(viewModel.errorMessage, AppConstants.Error.noCharacters)
    }

    func testLoadCharactersSuccess() async {
        let mockCharacters = [
            PotterCharacter(fullName: "Harry Potter"),
            PotterCharacter(fullName: "Hermione Jean Granger")
        ]
        mockService.mockCharacters = mockCharacters
        viewModel = CharactersListViewModel(service: mockService)

        await viewModel.loadCharacters()

        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.error)
        XCTAssertEqual(viewModel.characters?.count, mockCharacters.count)
    }

    func testLoadCharactersFailure() async {
        mockService.shouldThrowError = true
        viewModel = CharactersListViewModel(service: mockService)
        
        await viewModel.loadCharacters()
        
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNotNil(viewModel.error)
        XCTAssertNil(viewModel.characters)
    }
}

class MockCharactersService: CharacterServiceProtocol {
    var shouldThrowError = false
    var mockCharacters: [PotterCharacter]?
    var potterCharacter: PotterCharacter?

    func fetchCharacters() async throws -> [PotterCharacter] {
        if shouldThrowError {
            throw MockError.defaultError
        }
        return mockCharacters ?? []
    }
    
    func fetchCharacterDetail(index: Int) async throws -> PotterCharacter? {
        if shouldThrowError {
            throw MockError.defaultError
        }
        return potterCharacter
    }
}
