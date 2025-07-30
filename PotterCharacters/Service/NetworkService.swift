//
//  NetworkService.swift
//  PotterCharacters
//
//  Created by Kalaiyarasan on 29/07/25.
//

import Foundation

protocol NetworkServiceProtocol {
    func request<T: Decodable>(_ url: URL, responseType: T.Type) async throws -> T
}

class NetworkService: NetworkServiceProtocol {
    func request<T: Decodable>(_ url: URL, responseType: T.Type) async throws -> T {
        let urlString = url.absoluteString

        if let cacheData = await CacheManager.shared.getCacheResponse(for: urlString) {
            return try JSONDecoder().decode(responseType, from: cacheData)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        await CacheManager.shared.saveCacheResponse(for: urlString, data: data)

        return try JSONDecoder().decode(responseType, from: data)
    }
}
