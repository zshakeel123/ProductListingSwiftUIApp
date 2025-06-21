//
//  ProductServiceKitTests.swift
//  ProductServiceKitTests
//
//  Created by Zeeshan Shakeel on 14/06/2025.
//

import Testing
import Foundation
@testable import ProductServiceKit

struct ProductServiceKitTests {
    let baseURL = "https://dummyjson.com"
    let productsEndpoint = "/products"
    
    // Helper for creating a mock HTTP URL response
    private func mockHTTPResponse(statusCode: Int, url: URL? = nil) -> HTTPURLResponse? {
        let actualURL = url ?? URL(string: "\(baseURL)\(productsEndpoint)")!
        return HTTPURLResponse(url: actualURL, statusCode: statusCode, httpVersion: nil, headerFields: nil)
    }
    
    // MARK: - Test Cases for Successful Fetch
    
    @Test func testSuccessfulProductFetch() async throws {
        // Arrange: Prepare mock data and response
        let mockProductResponse = ProductResponse(
            products: [
                Product(id: 1, title: "Test Product", description: "Desc", price: 100, discountPercentage: 10, rating: 4.5, stock: 50, brand: "Test", category: "Test", thumbnail: "thumb.jpg", images: [])
            ],
            total: 1,
            skip: 0,
            limit: 1
        )
        
        let jsonData = try JSONEncoder().encode(mockProductResponse)
        let url = URL(string: "\(baseURL)\(productsEndpoint)?skip=0&limit=10")!
        let httpResponse = mockHTTPResponse(statusCode: 200, url: url)
        
        let mockSession = MockURLSession(data: jsonData, response: httpResponse)
        
        // Act: Initialize service with mock session and call fetch
        let productService = ProductService(baseURLString: baseURL, productEndPoint: productsEndpoint, session: mockSession)
        let response = try await productService.fetchProducts(skip: 0, limit: 10)
        
        // Assert: Verify the results
        #expect(response.products.count == 1)
        #expect(response.products.first?.title == "Test Product")
        #expect(response.total == 1)
        #expect(response.skip == 0)
        #expect(response.limit == 1)
        #expect(response.products.first?.id == 1)
    }
    
    // MARK: - Test Cases for Error Handling
    
    @Test func testFetchProducts_InvalidURL() async throws {
        // Arrange: Service with malformed URL components.
        let invalidUrlString = "this is not valid url"
        let service = ProductService(baseURLString: invalidUrlString, productEndPoint: "products", session: MockURLSession(response: mockHTTPResponse(statusCode: 500, url: URL(string: invalidUrlString))))
        
        // Act & Assert: Expect an error to be thrown
        await #expect(throws: NetworkingError.noData) {
            try await service.fetchProducts(skip: 0, limit: 10)
        }
    }
    
    @Test func testFetchProducts_MissingAPIEndpoint() async throws {
        // Arrange: Service with empty base URL and endpoint
        let service = ProductService(baseURLString: "", productEndPoint: "", session: URLSession.shared)
        
        // Act & Assert: Expect an error to be thrown
        await #expect(throws: NetworkingError.missingAPIEndpoint) {
            try await service.fetchProducts(skip: 0, limit: 10)
        }
    }
    
    @Test func testFetchProducts_RequestFailed() async throws {
        // Arrange: Mock session that returns a network error (e.g., no internet)
        let mockError = URLError(.notConnectedToInternet) // Use URLError for more specific network errors
        let mockSession = MockURLSession(error: mockError)
        let service = ProductService(baseURLString: baseURL, productEndPoint: productsEndpoint, session: mockSession)
        
        // Act & Assert: Expect an error to be thrown
        await #expect(throws: NetworkingError.requestFailed(mockError)) {
            try await service.fetchProducts(skip: 0, limit: 10)
        }
    }
    
    @Test func testFetchProducts_InvalidResponse() async throws {
        // Arrange: Mock session returning nil response (not HTTPURLResponse)
        let mockSession = MockURLSession(data: Data(), response: nil) // Simulate nil response
        let service = ProductService(baseURLString: baseURL, productEndPoint: productsEndpoint, session: mockSession)
        
        // Act & Assert: Expect an error to be thrown
        await #expect(throws: NetworkingError.invalidResponse) {
            try await service.fetchProducts(skip: 0, limit: 10)
        }
    }
    
    @Test func testFetchProducts_ServerError() async throws {
        // Arrange: Mock session returning a 500 HTTP response
        let url = URL(string: "\(baseURL)\(productsEndpoint)?skip=0&limit=10")!
        let httpResponse = mockHTTPResponse(statusCode: 500, url: url)
        let mockSession = MockURLSession(data: Data(), response: httpResponse)
        let service = ProductService(baseURLString: baseURL, productEndPoint: productsEndpoint, session: mockSession)
        
        // Act & Assert: Expect an error to be thrown
        await #expect(throws: NetworkingError.serverError(statusCode: 500)) {
            try await service.fetchProducts(skip: 0, limit: 10)
        }
    }
    
    @Test func testFetchProducts_NoData() async throws {
        // Arrange: Mock session returning valid response but no data
        let url = URL(string: "\(baseURL)\(productsEndpoint)?skip=0&limit=10")!
        let httpResponse = mockHTTPResponse(statusCode: 200, url: url)
        let mockSession = MockURLSession(data: nil, response: httpResponse) // Nil data
        let service = ProductService(baseURLString: baseURL, productEndPoint: productsEndpoint, session: mockSession)
        
        // Act & Assert: Expect an error to be thrown
        await #expect(throws: NetworkingError.noData) {
            try await service.fetchProducts(skip: 0, limit: 10)
        }
    }
    
    @Test func testFetchProducts_DecodingError() async throws {
        // Arrange: Mock session returning invalid JSON data
        let invalidJsonData = "{\"invalid_key\": \"invalid_value\"}".data(using: .utf8)!
        let url = URL(string: "\(baseURL)\(productsEndpoint)?skip=0&limit=10")!
        let httpResponse = mockHTTPResponse(statusCode: 200, url: url)
        let mockSession = MockURLSession(data: invalidJsonData, response: httpResponse)
        let service = ProductService(baseURLString: baseURL, productEndPoint: productsEndpoint, session: mockSession)
        
        // Act & Assert: Expect an error to be thrown. We check for the type of error.
        await #expect(throws: NetworkingError.decodingError(DecodingError.dataCorrupted(DecodingError.Context(codingPath: [], debugDescription: "")))) {
            // The exact DecodingError thrown by JSONDecoder can be complex.
            // We'll provide a dummy context for comparison as the exact context varies.
            try await service.fetchProducts(skip: 0, limit: 10)
        }
    }
}
