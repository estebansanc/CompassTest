//
//  HttpClient.swift
//  Articles
//
//  Created by Esteban Sánchez on 23/02/2024.
//

import Foundation

enum HttpError: Error, LocalizedError {
    case invalidURL
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "You provided an invalid URL"
        }
    }
}
