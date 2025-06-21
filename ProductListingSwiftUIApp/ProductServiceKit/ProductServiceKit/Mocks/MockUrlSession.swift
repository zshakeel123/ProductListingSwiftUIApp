//
//  MockUrlSession.swift
//  ProductServiceKit
//
//  Created by Zeeshan Shakeel on 17/06/2025.
//

import Foundation

// MockURLSessionDataTask is still useful if URLSessionProtocol required dataTask(with:)
class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    private let closure: () -> Void

    init(closure: @escaping () -> Void) {
        self.closure = closure
    }

    func resume() {
        // In a real async mock, this might just immediately call the closure
        // as `await` doesn't "resume" in the same way callbacks do.
        closure()
    }
}

class MockURLSession: URLSessionProtocol {
    var mockData: Data?
    var mockResponse: URLResponse?
    var mockError: Error?
    
    // Expected parameters for assertion to ensure logic
    var expectedURL: URL? // to ensure url construction logic is correct
    var expectedURLRequest: URLRequest? // to ensure url request construction logic is correct

    init(data: Data? = nil, response: URLResponse? = nil, error: Error? = nil) {
        self.mockData = data
        self.mockResponse = response
        self.mockError = error
    }

    // --- Conform to URLSessionProtocol methods ---

    // For callback-based dataTask (if still needed by IProductService)
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        // Simulate immediate completion for testing
        return MockURLSessionDataTask { [weak self] in
            guard let self = self else { return }
            completionHandler(self.mockData, self.mockResponse, self.mockError)
        }
    }

    // Conformance for async data(for:delegate:)
    func data(for request: URLRequest, delegate: (any URLSessionTaskDelegate)?) async throws -> (Data, URLResponse) {
        // Assert the request if needed (to ensure url request construction logic is correct)
        if let expectedRequest = expectedURLRequest {
            if request != expectedRequest {
                // If the requests don't match, you might throw an error or record an issue
                throw NSError(domain: "MockURLSessionError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Request URL mismatch: Expected \(expectedRequest.url?.absoluteString ?? "nil") got \(request.url?.absoluteString ?? "nil")"])
            }
        }
        
        if let error = mockError {
            throw error
        }
        
        guard let response = mockResponse else {
            throw NetworkingError.invalidResponse
        }
        
        guard let data = mockData else {
            throw NetworkingError.noData
        }
        
        return (data, response)
    }

    // Conformance for async data(from:delegate:)
    func data(from url: URL, delegate: (any URLSessionTaskDelegate)?) async throws -> (Data, URLResponse) {
        // Assert the URL if needed (to ensure url construction logic is correct)
        if let expected = expectedURL {
            if url != expected {
                // If URLs don't match, you might throw an error or record an issue
                throw NSError(domain: "MockURLSessionError", code: 0, userInfo: [NSLocalizedDescriptionKey: "URL mismatch: Expected \(expected.absoluteString) got \(url.absoluteString)"])
            }
        }
        
        if let error = mockError {
            throw error
        }
        
        guard let response = mockResponse else {
            throw NetworkingError.invalidResponse
        }
        
        guard let data = mockData else {
            throw NetworkingError.noData
        }
        
        return (data, response)
    }
}
