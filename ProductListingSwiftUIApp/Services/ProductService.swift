//
//  ProductService.swift
//  ProductUIKitApp
//
//  Created by Zeeshan Shakeel on 15/05/2025.
//

import Foundation

protocol IProductService {
    func fetchProducts(skip: Int, limit: Int, completion: @escaping (Result<ProductResponse, NetworkingError>) -> Void)
    
}

class ProductService: IProductService {
    
    var mockResult: Result<ProductResponse, Error>!
    
    func fetchProducts(skip: Int, limit: Int, completion: @escaping (Result<ProductResponse, NetworkingError>) -> Void) {
        //let urlString = "https://dummyjson.com/products?skip=\(skip)&limit=\(limit)"
        let urlString = "\(AppConstants.API.baseURLString)\(AppConstants.API.productsEndpoint)?skip=\(skip)&limit=\(limit)"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error  in
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

