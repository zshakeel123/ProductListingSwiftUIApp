//
//  ProductRowView.swift
//  ProductListingSwiftUIApp
//
//  Created by Zeeshan Shakeel on 21/05/2025.
//

import SwiftUI

public struct ProductRowView: View {
    let product: Product
    
    public var body: some View {
        HStack {
            AsyncImage(url: URL(string: product.thumbnail)){ image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80, height: 80)
                    .cornerRadius(8)
            } placeholder: {
                ProgressView()
                    .frame(width: 80, height: 80)
                    .background(AppConstants.Colors.background.opacity(0.2))
                    .cornerRadius(8)
            }
            
            VStack(alignment: .leading) {
                Text("\(product.title)")
                    .font(.headline)
                
                Text(String(format: "$ %.2f", product.price))
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding(AppConstants.UI.defaultPadding / 2)
        .background(AppConstants.Colors.cellBackground)
        .cornerRadius(AppConstants.UI.defaultPadding / 2)
    }
}


#Preview {
    let mockProduct = Product(id: 1, title: "Test Product 1", description: "", price: 10, discountPercentage: 0, rating: 5, stock: 0, brand: nil, category: "", thumbnail: "https://cdn.dummyjson.com/product-images/furniture/annibale-colombo-sofa/thumbnail.webp", images: [])
    
    ProductRowView(product: mockProduct)
//        .padding()
//        .background(AppConstants.Colors.background)
}
