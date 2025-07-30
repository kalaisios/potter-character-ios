//
//  PotterCharacter.swift
//  PotterCharacters
//
//  Created by Kalaiyarasan on 28/07/25.
//

import Foundation

struct PotterCharacter: Codable {
    let index: Int?
    let fullName: String?
    let nickname: String?
    let hogwartsHouse: String?
    let interpretedBy: String?
    let image: String?
    let birthdate: String?
    let children: [String]?
    
    init(index: Int? = nil,
        fullName: String? = nil,
        nickname: String? = nil,
        hogwartsHouse: String? = nil,
        interpretedBy: String? = nil,
        image: String? = nil,
        birthdate: String? = nil,
        children: [String]? = nil) {
        self.index = index
        self.fullName = fullName
        self.nickname = nickname
        self.hogwartsHouse = hogwartsHouse
        self.interpretedBy = interpretedBy
        self.image = image
        self.birthdate = birthdate
        self.children = children
    }
}
