//
//  ProductListingView.swift
//  ProductListingSwiftUIApp
//
//  Created by Zeeshan Shakeel on 06/06/2025.
//

import SwiftUI

struct ProductListingView<ViewModel: IProductListViewModel>: View {
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        List{
            ForEach(viewModel.products) { product in
                ProductRowView(product: product)
            }
        }
        .onAppear() {
            if(viewModel.products.isEmpty && !viewModel.isLoading){
                viewModel.loadProducts()
            }
        }
    }
}

#Preview {
    ProductListingView(viewModel: MockProductListViewModel())
}
