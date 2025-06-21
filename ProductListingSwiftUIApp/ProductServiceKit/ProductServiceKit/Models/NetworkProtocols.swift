//
//  NetworkProtocols.swift
//  ProductServiceKit
//
//  Created by Zeeshan Shakeel on 15/06/2025.
//

import Foundation

public protocol IProductService {
    init(baseURLString: String, productEndPoint: String, session: URLSessionProtocol)
    func fetchProducts(skip: Int, limit: Int) async throws -> ProductResponse
//    func fetchProducts(skip: Int, limit: Int, completion: @escaping (Result<ProductResponse, NetworkingError>) -> Void)
}

// Protocal to for URLSession to give asycn/await behaviour as per modern swift best practices.
public protocol URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol
    // Aync/Await variants
    func data(for request: URLRequest, delegate: (any URLSessionTaskDelegate)?) async throws -> (Data, URLResponse)
    func data(from url: URL, delegate: (any URLSessionTaskDelegate)?) async throws -> (Data, URLResponse)
}

public protocol URLSessionDataTaskProtocol {
    func resume()
}

// Conform URLSession to URLSessionProtocol
extension URLSession: URLSessionProtocol {
    public func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, (any Error)?) -> Void) -> any URLSessionDataTaskProtocol {
        return dataTask(with: url, completionHandler: completionHandler) as URLSessionDataTask
    }
}

// Conform URLSessionDataTask to URLSessionDataTaskProtocol
extension URLSessionDataTask: URLSessionDataTaskProtocol {}


