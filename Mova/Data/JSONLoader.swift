//
//  JSONLoader.swift
//  Mova
//
//  Created by Muhammad Tayyab Nadeem on 17/04/2026.
//

import JavaScriptCore
final class JSONLoader {

    static func loadMovies() -> MoviesResponse? {
        guard let url = Bundle.main.url(forResource: "Movies", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            print("Failed to load JSON")
            return nil
        }

        do {
            let decoded = try JSONDecoder().decode(MoviesResponse.self, from: data)
            return decoded
        } catch {
            print("Decoding error:", error)
            return nil
        }
    }
}
