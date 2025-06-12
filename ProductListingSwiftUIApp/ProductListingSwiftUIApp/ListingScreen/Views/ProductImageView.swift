//
//  ProductImageView.swift
//  ProductListingSwiftUIApp
//
//  Created by Zeeshan Shakeel on 06/06/2025.
//


import SwiftUI

struct ProductImageView: View {
    var imageUrlString: String
    var body: some View {
        AsyncImage(url: URL(string: imageUrlString)){ image in
            image.resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80, height: 80)
                .cornerRadius(8)
        } placeholder: {
            ZStack {
                Image(systemName: "box.truck.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                    .foregroundColor(.gray)
                    .cornerRadius(8)
                
                ProgressView()
                    .frame(width: 80, height: 80)
                    .background(AppConstants.Colors.background.opacity(0.2))
                    .cornerRadius(8)
            }
        }
    }
}

#Preview {
    ProductImageView(imageUrlString: "https://cdn.dummyjson.com/product-images/furniture/annibale-colombo-sofa/thumbnail.webp")
    ProductImageView(imageUrlString: "https://cdn.dummyjson.com/product-images/furniture/invalid_url")
}
