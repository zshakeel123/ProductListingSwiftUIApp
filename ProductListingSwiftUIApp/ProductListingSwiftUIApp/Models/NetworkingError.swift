//
//  NetworkingError.swift
//  ProductListingSwiftUIApp
//
//  Created by Zeeshan Shakeel on 12/06/2025.
//

import Foundation

enum NetworkingError: Error, LocalizedError {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case decodingError(Error)
    case noData
    case serverError(statusCode: Int)
    case unknownError
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The product URL is invalid. Please check the address."
        case .requestFailed(let error):
            return "Network request failed: \(error.localizedDescription). Please check your internet connection."
        case .invalidResponse:
            return "Received an invalid response from the server."
        case .decodingError(let error):
            return "Failed to process data from the server. \(error.localizedDescription)"
        case .noData:
            return "No data returned from the server."
        case .serverError(let statusCode):
            return "Server error with status code: \(statusCode). Please try again later."
        case .unknownError:
            return "An unexpected error occurred. Please try again."
        }
    }
}
