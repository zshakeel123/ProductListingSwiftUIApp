//
//  ProductRowView.swift
//  ProductListingSwiftUIApp
//
//  Created by Zeeshan Shakeel on 21/05/2025.
//

import SwiftUI
import ProductServiceKit

public struct ProductRowView: View {
    let product: Product
    
    public var body: some View {
        HStack {
            ProductImageView(imageUrlString: product.thumbnail)
            VStack(alignment: .leading) {
                Text("\(product.title)")
                    .font(.headline)
                
                Text(String(format: "$ %.2f", product.price))
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding(AppConstants.UI.defaultPadding)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(AppConstants.Colors.cellBackground)
        .cornerRadius(AppConstants.UI.defaultPadding)
    }
}


#Preview {
    let mockProduct = Product(id: 1, title: "Test Product 1", description: "", price: 10, discountPercentage: 0, rating: 5, stock: 0, brand: nil, category: "", thumbnail: "https://cdn.dummyjson.com/product-images/furniture/annibale-colombo-sofa/thumbnail.webp", images: [])
    
    let mockProduct2 = Product(id: 1, title: "Test Product 2", description: "", price: 15, discountPercentage: 0, rating: 5, stock: 0, brand: nil, category: "", thumbnail: "https://cdn.dummyjson.com/product-images/furniture/invalid_url1", images: [])
    
    List{
        ProductRowView(product: mockProduct)
        ProductRowView(product: mockProduct2)
    }
}


