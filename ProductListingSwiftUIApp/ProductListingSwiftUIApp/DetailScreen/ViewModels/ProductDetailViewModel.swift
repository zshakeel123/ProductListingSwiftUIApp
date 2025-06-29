//
//  ProductDetailViewModel.swift
//  ProductUIKitApp
//
//  Created by Zeeshan Shakeel on 21/05/2025.
//

import Foundation
import ProductServiceKit

class ProductDetailViewModel {
    private let product: Product
    
    init(product: Product) {
        self.product = product
    }
    
    var title: String {
        product.title
    }
    
    var description: String {
        product.description
    }
    
    var price: String {
        String(format: "$ %.2f", product.price)
    }
    
    var thumbnailURL: String {
        product.thumbnail
    }
    
    var brand: String {
        "Brand: \(product.brand ?? "N/A")"
    }
    
    var category: String {
        "Category: \(product.category)"
    }
    
    var stock: String {
        "In Stock: \(product.stock)"
    }
    
    var rating: String {
        "Rating: \(String(format: "%.1f", product.rating)) / 5.0"
    }
    
}
