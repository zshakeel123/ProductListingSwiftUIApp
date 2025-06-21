//
//  ProductService.swift
//  ProductService
//
//  Created by Zeeshan Shakeel on 12/06/2025.
//


import Foundation

public class ProductService: IProductService {
    private let baseURLString: String
    private let productEndPoint: String
    private let session: URLSessionProtocol
    
    public required init(baseURLString: String, productEndPoint: String = "", session: URLSessionProtocol = URLSession.shared) {
        self.baseURLString = baseURLString
        self.productEndPoint = productEndPoint
        self.session = session
    }
    
    public func fetchProducts(skip: Int, limit: Int) async throws -> ProductResponse {
        // Missing API EndPoint.
        guard !baseURLString.isEmpty && !productEndPoint.isEmpty else {
            throw NetworkingError.missingAPIEndpoint
        }
        
        let urlString = "\(baseURLString)\(productEndPoint)?skip=\(skip)&limit=\(limit)"
        
        // Invalid Url
        guard let url = URL(string: urlString) else {
            throw NetworkingError.invalidURL
        }
        
        do {
            let (data, response) = try await self.session.data(from: url, delegate: nil)
            
            // Invalid Response
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkingError.invalidResponse
            }
            
            // Invalid Http Response Code
            guard (200...299).contains(httpResponse.statusCode) else {
                throw NetworkingError.serverError(statusCode: httpResponse.statusCode)
            }
            
            // Decode json into the model.
            let decoder = JSONDecoder()
            let productResponse = try decoder.decode(ProductResponse.self, from: data)
            return productResponse
        } catch let urlError as URLError {
            throw NetworkingError.requestFailed(urlError)
        } catch let jsonDecodingError as DecodingError {
            throw NetworkingError.decodingError(jsonDecodingError)
        } catch let networkingError as NetworkingError {
            // Re-throw our custom networking errors directly
            throw networkingError
        } catch {
            // Catch any other unexpected errors
            throw NetworkingError.unknownError
        }
        
    }
}

