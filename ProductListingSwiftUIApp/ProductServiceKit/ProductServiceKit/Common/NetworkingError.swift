//
//  NetworkingError.swift
//  ProductListingSwiftUIApp
//
//  Created by Zeeshan Shakeel on 12/06/2025.
//

import Foundation

public enum NetworkingError: Error, LocalizedError, Equatable {
    case missingAPIEndpoint
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case decodingError(Error)
    case noData
    case serverError(statusCode: Int)
    case unknownError
    
    public var errorDescription: String? {
        switch self {
        case .missingAPIEndpoint:
            return "The API endpoint is missing. Please check the configuration."
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
    
    // NetworkingError needs to be Equatable for direct comparison in tests
    public static func == (lhs: NetworkingError, rhs: NetworkingError) -> Bool {
        switch (lhs, rhs) {
        case (.missingAPIEndpoint, .missingAPIEndpoint),
            (.invalidURL, .invalidURL),
            (.invalidResponse, .invalidResponse),
            (.noData, .noData),
            (.unknownError, .unknownError):
            return true
        case (.requestFailed(let lError), .requestFailed(let rError)):
            // Compare NSError codes and domains for URLErrors
            return (lError as NSError).domain == (rError as NSError).domain &&
            (lError as NSError).code == (rError as NSError).code
        case (.serverError(let lCode), .serverError(let rCode)):
            return lCode == rCode
        case (.decodingError(_), .decodingError(_)):
            // For decoding errors, we typically care about the type of error, not its exact details
            return true
        default:
            return false
        }
    }
}
