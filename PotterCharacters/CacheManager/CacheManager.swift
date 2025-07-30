//
//  CacheManager.swift
//  PotterCharacters
//
//  Created by Kalaiyarasan on 29/07/25.
//

import Foundation
import SwiftData

@MainActor
class CacheManager {
    static let shared = CacheManager()
    let container: ModelContainer?

    private init() {
        let schema = Schema([CachedResponse.self])
        self.container = try? ModelContainer(for: schema)
    }

    var context: ModelContext? {
        container?.mainContext
    }

    private let expiryTimeInterval: TimeInterval = 3600

    func getCacheResponse(for url: String) -> Data? {
        let fetchDescriptor = FetchDescriptor<CachedResponse>(
            predicate: #Predicate { $0.url == url }
        )

        guard let cachedResponse = try? context?.fetch(fetchDescriptor).first else {
            return nil
        }

        guard Date().timeIntervalSince(cachedResponse.timestamp) < expiryTimeInterval else {
            context?.delete(cachedResponse)
            try? context?.save()
            return nil
        }

        return cachedResponse.data
    }

    func saveCacheResponse(for url: String, data: Data) {
        let fetchDescriptor = FetchDescriptor<CachedResponse>(
            predicate: #Predicate { $0.url == url }
        )
        
        if let cachedResponse = try? context?.fetch(fetchDescriptor).first {
            context?.delete(cachedResponse)
            try? context?.save()
        }
    
        context?.insert(CachedResponse(url: url, data: data))
        try? context?.save()
    }
}
