//
//  CharacterDetailViewModelTests.swift
//  PotterCharactersTests
//
//  Created by Kalaiyarasan on 30/07/25.
//

import XCTest
@testable import PotterCharacters

final class CharacterDetailViewModelTests: XCTestCase {
    var viewModel: CharacterDetailViewModel!
    var mockService: MockCharactersService!

    override func setUp() {
        super.setUp()
        mockService = MockCharactersService()
        viewModel = CharacterDetailViewModel(service: mockService)
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
        viewModel.error = URLError(.badServerResponse)
        XCTAssertEqual(viewModel.errorMessage, AppConstants.Error.unableToFetchData)
    }

    func testFetchCharacterDetailsSuccess() async {
        let mockCharacter = PotterCharacter(index: 1,
                                            fullName: "Harry James Potter",
                                            nickname: "Harry",
                                            hogwartsHouse: "Gryffindor",
                                            interpretedBy: "Daniel Radcliffe",
                                            image: "https://raw.githubusercontent.com/fedeperin/potterapi/main/public/images/characters/harry_potter.png",
                                            birthdate: "Jul 31, 1980",
                                            children: [
                                                "James Sirius Potter",
                                                "Albus Severus Potter",
                                                "Lily Luna Potter"
                                            ])
        
        mockService.potterCharacter = mockCharacter
        viewModel = CharacterDetailViewModel(service: mockService)
        
        await viewModel.fetchCharacterDetails(with: 1)
        
        XCTAssertEqual(viewModel.character?.index, mockCharacter.index)
        XCTAssertEqual(viewModel.character?.fullName, mockCharacter.fullName)
        XCTAssertEqual(viewModel.character?.nickname, mockCharacter.nickname)
        XCTAssertEqual(viewModel.character?.hogwartsHouse, mockCharacter.hogwartsHouse)
        XCTAssertEqual(viewModel.character?.interpretedBy, mockCharacter.interpretedBy)
        XCTAssertEqual(viewModel.character?.image, mockCharacter.image)
        XCTAssertEqual(viewModel.character?.birthdate, mockCharacter.birthdate)
        XCTAssertEqual(viewModel.character?.children?.count, mockCharacter.children?.count)
    }

    func testFetchCharacterDetailsFailure() async {
        mockService.shouldThrowError = true
        viewModel = CharacterDetailViewModel(service: mockService)
        
        await viewModel.fetchCharacterDetails(with: 1)
        
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNotNil(viewModel.error)
        XCTAssertNil(viewModel.character)
    }
}
