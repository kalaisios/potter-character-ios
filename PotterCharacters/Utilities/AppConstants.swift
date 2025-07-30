//
//  AppConstants.swift
//  PotterCharacters
//
//  Created by Kalaiyarasan on 29/07/25.
//

import Foundation

struct AppConstants {
    static let baseURL = "https://potterapi-fedeperin.vercel.app/en"

    struct Endpoints {
        static let characters = "/characters"
        static let charactersWithIndex = "/characters?index=%@"
    }
    
    struct Error {
        static let noCharacters = "No characters found"
        static let unableToFetchData = "Unable to fetch data"
        static let defaultMessage = "Something went wrong"
    }
    
    static let charactersList = "Characters List"
    static let character = "Character"
    static let potterCharacters = "Potter Characters"
    static let interpretedBy = "Interpreted By:"
    static let hogwartsHouse = "Hogwarts House:"
    static let children = "Children"
}
