//
//  MovieRouter.swift
//  Mova
//
//  Created by Muhammad Tayyab Nadeem on 21/04/2026.
//

import Foundation

enum MovieRouter {
    case getAll
}

extension MovieRouter: APIEndpoint {
    
    var baseURL: String {
        return "https://rickandmortyapi.com"
    }
    
    var path: String {
        return "/api/character"
    }
    
    var method: HTTPMethod {
        return .get
    }
    var queryItems: [URLQueryItem]? {
        switch self {
        case .getAll:
            return nil
            
        }
    }
}
