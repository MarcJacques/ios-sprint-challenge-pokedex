//
//  Enum.swift
//  Pokedex
//
//  Created by Marc Jacques on 9/7/19.
//  Copyright © 2019 Marc Jacques. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}

enum NetworkError: Error {
    case badURL
    case noToken
    case noData
    case notDecoding
    case notEncoding
    case otherError(Error)
}
