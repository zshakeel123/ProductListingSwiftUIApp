//
//  ProductService.swift
//  ProductUIKitApp
//
//  Created by Zeeshan Shakeel on 15/05/2025.
//

import Foundation

protocol IProductService {
    func fetchProducts(skip: Int, limit: Int, completion: @escaping (Result<ProductResponse, Error>) -> Void)
    
}

class ProductService: IProductService {
    
    var mockResult: Result<ProductResponse, Error>!
    
    func fetchProducts(skip: Int, limit: Int, completion: @escaping (Result<ProductResponse, Error>) -> Void) {
        //let urlString = "https://dummyjson.com/products?skip=\(skip)&limit=\(limit)"
        let urlString = "\(AppConstants.API.baseURLString)\(AppConstants.API.productsEndpoint)?skip=\(skip)&limit=\(limit)"
        
//        AF.request(urlString).responseDecodable(of: ProductResponse.self) { response in
//            completion(response.result)
        completion(mockResult)
        }
    }

