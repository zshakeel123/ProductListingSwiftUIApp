//
//  ProductDetailView.swift
//  ProductListingSwiftUIApp
//
//  Created by Zeeshan Shakeel on 08/06/2025.
//

import SwiftUI
import ProductServiceKit

struct ProductDetailView: View {
    @State private var viewModel: ProductDetailViewModel
    
    init(product: Product) {
        _viewModel = .init(wrappedValue: ProductDetailViewModel(product: product))
    }
    
    var body: some View {
         ScrollView {
             VStack (alignment: .leading, spacing: AppConstants.UI.defaultPadding / 2) {
                 AsyncImage(url: URL(string: viewModel.thumbnailURL)) { image in
                     image.resizable()
                         .aspectRatio(contentMode: .fill)
                         .frame(height: 250)
                     //                    .clipped()
                     //                    .cornerRadius(AppConstants.UI.defaultPadding)
                 } placeholder: {
                     ProgressView()
                         .frame(height: 250)
                         .frame(maxWidth: .infinity)
                 }
                 
                 VStack (alignment: .leading, spacing: AppConstants.UI.defaultPadding / 2) {
                     Text(viewModel.title)
                         .font(.largeTitle)
                         .fontWeight(.bold)
                         .foregroundColor(.primary)
                     Text(viewModel.price)
                         .font(.title2)
                         .fontWeight(.heavy)
                         .foregroundColor(.green)
                     Divider()
                     Text(viewModel.description)
                         .font(.body)
                         .foregroundColor(.secondary)
                     //                .fixedSize(horizontal: false, vertical: true)
                     
                     Group{
                         Text(viewModel.brand)
                         Text(viewModel.category)
                         Text(viewModel.stock)
                             .foregroundColor(viewModel.stock.contains("In Stock: 0") ? .red : .green)
                         Text(viewModel.rating)
                     }
                     .foregroundColor(.accentColor)
                     .font(.subheadline)
                     .padding(.leading, AppConstants.UI.defaultPadding)
                     .padding(.trailing, AppConstants.UI.defaultPadding)
                     
                 }
                 .padding()
                 .navigationTitle(viewModel.title)
                 .navigationBarTitleDisplayMode(.inline)
             }
        }
         //.ignoresSafeArea(.all, edges: .all)
        
    }
}

#Preview {
    let mockProduct1 = Product(id: 1, title: "Delux Sofa Set", description: "The Annibale Colombo Sofa is a sophisticated and comfortable seating option, featuring exquisite design and premium upholstery for your living room.", price: 10, discountPercentage: 0, rating: 5, stock: 0, brand: nil, category: "", thumbnail: "https://cdn.dummyjson.com/product-images/furniture/annibale-colombo-sofa/thumbnail.webp", images: [])
    
    NavigationStack {
        ProductDetailView(product: mockProduct1)
    }
}
