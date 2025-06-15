//
//  Product.swift
//  ProductUIKitApp
//
//  Created by Zeeshan Shakeel on 21/05/2025.
//

import Foundation

public struct ProductResponse: Codable {
    public let products: [Product]
    public let total: Int
    public let skip: Int
    public let limit: Int
}

public struct Product: Codable, Identifiable {
    public let id: Int
    public let title: String
    public let description: String
    public let price: Double
    public let discountPercentage: Double
    public let rating: Double
    public let stock: Int
    public let brand: String?
    public let category: String
    public let thumbnail: String
    public let images: [String]
    
    // Explicit public initializer
    // This makes the memberwise initializer accessible from outside the module
    public init(id: Int, title: String, description: String, price: Double, discountPercentage: Double, rating: Double, stock: Int, brand: String?, category: String, thumbnail: String, images: [String]) {
        self.id = id
        self.title = title
        self.description = description
        self.price = price
        self.discountPercentage = discountPercentage
        self.rating = rating
        self.stock = stock
        self.brand = brand
        self.category = category
        self.thumbnail = thumbnail
        self.images = images
    }
}
