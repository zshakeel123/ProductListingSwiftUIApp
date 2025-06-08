//
//  ProductListingView.swift
//  ProductListingSwiftUIApp
//
//  Created by Zeeshan Shakeel on 06/06/2025.
//

import SwiftUI

struct ProductListingView: View {
    var products: [Product] = []
    
    var body: some View {
        List{
            ForEach(products) { product in
                ProductRowView(product: product)
            }
        }
    }
}

#Preview {
    let mockProduct1 = Product(id: 1, title: "Test Product 1", description: "", price: 10, discountPercentage: 0, rating: 5, stock: 0, brand: nil, category: "", thumbnail: "https://cdn.dummyjson.com/product-images/furniture/annibale-colombo-sofa/thumbnail.webp", images: [])
    
    let mockProduct2 = Product(id: 2, title: "Test Product 2", description: "", price: 15, discountPercentage: 0, rating: 5, stock: 0, brand: nil, category: "", thumbnail: "https://cdn.dummyjson.com/product-images/furniture/invalid_url1", images: [])
    
    
    ProductListingView(products: [mockProduct1, mockProduct2])
}
