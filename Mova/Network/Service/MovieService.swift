//
//  MovieService.swift
//  Mova
//
//  Created by Muhammad Tayyab Nadeem on 21/04/2026.
//

import Foundation

protocol MovieServiceType {
    func fetchCharacters() async throws -> [Character]
    func fetchCharactersResult() async -> Result<[Character], NetworkError>
}

final class MovieService: MovieServiceType {
    func fetchCharactersResult() async -> Result<[Character], NetworkError> {
        do {
            let request = try RequestBuilder.build(from: MovieRouter.getAll)
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let http = response as? HTTPURLResponse,
                  200..<300 ~= http.statusCode else {
                return .failure(.invalidResponse)
            }
            let decoded = try JSONDecoder().decode(CharacterResponse.self, from: data)
            return .success(decoded.results)
        } catch {
            return .failure(.decodingError)
        }
    }
    

    func fetchCharacters() async throws -> [Character] {

        let request = try RequestBuilder.build(from: MovieRouter.getAll)
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let http = response as? HTTPURLResponse,
              200..<300 ~= http.statusCode else {
            throw NetworkError.invalidResponse
        }
        do {
            let decoded = try JSONDecoder().decode(CharacterResponse.self, from: data)
            return decoded.results
        } catch {
            throw NetworkError.decodingError
        }
    }
}
