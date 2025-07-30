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
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(responseType, from: data)
    }
}
