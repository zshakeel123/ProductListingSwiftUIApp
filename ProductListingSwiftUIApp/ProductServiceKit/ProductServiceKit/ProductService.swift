//
//  ProductService.swift
//  ProductService
//
//  Created by Zeeshan Shakeel on 12/06/2025.
//


import Foundation

public protocol IProductService {
    init(baseURLString: String, productEndPoint: String, session: URLSession)
    func fetchProducts(skip: Int, limit: Int, completion: @escaping (Result<ProductResponse, NetworkingError>) -> Void)
}

public class ProductService: IProductService {
    private let baseURLString: String
    private let productEndPoint: String
    private let session: URLSession
    
    public required init(baseURLString: String, productEndPoint: String = "", session: URLSession = .shared) {
        self.baseURLString = baseURLString
        self.productEndPoint = productEndPoint
        self.session = session
    }
    
    public func fetchProducts(skip: Int, limit: Int, completion: @escaping (Result<ProductResponse, NetworkingError>) -> Void) {
        // Missing API EndPoint.
        guard !baseURLString.isEmpty && !productEndPoint.isEmpty else {
            completion(.failure(.missingAPIEndpoint))
            return
        }
        
        let urlString = "\(baseURLString)\(productEndPoint)?skip=\(skip)&limit=\(limit)"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        
        self.session.dataTask(with: url) { data, response, error  in
            // Request failed
            if let error = error {
                completion(.failure(.requestFailed(error)))
                return
            }
            
            // Invalid Response
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.invalidResponse))
                return
            }
            
            // Invalid Http Response Code
            guard (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.serverError(statusCode: httpResponse.statusCode)))
                return
            }
            
            // No Data Recieved
            guard let data = data else  {
                completion(.failure(.noData))
                return
            }
            
            // Decode json into the model.
            do {
                let decoder = JSONDecoder()
                let responseModel = try decoder.decode(ProductResponse.self, from: data)
                completion(.success(responseModel))
            } catch {
                // Decode or JSON parsing error
                completion(.failure(.decodingError(error)))
            }
        }.resume()
    }
}

