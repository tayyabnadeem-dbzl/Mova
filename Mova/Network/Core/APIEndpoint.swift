//
//  APIEndpoint.swift
//  Mova
//
//  Created by Muhammad Tayyab Nadeem on 21/04/2026.
//

import Foundation

protocol APIEndpoint {
    var baseURL : String {get}
    var path : String {get}
    var method : HTTPMethod {get}
    var queryItems: [URLQueryItem]? { get }
}

