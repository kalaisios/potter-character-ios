//
//  CachedResponse.swift
//  PotterCharacters
//
//  Created by Kalaiyarasan on 30/07/25.
//

import Foundation
import SwiftData

@Model
class CachedResponse {
    @Attribute(.unique) var url: String
    var data: Data
    var timestamp: Date
    
    init(url: String, data: Data, timestamp: Date = Date()) {
        self.url = url
        self.data = data
        self.timestamp = timestamp
    }
}
