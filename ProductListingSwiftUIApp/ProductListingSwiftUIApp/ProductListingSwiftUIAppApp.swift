//
//  ProductListingSwiftUIAppApp.swift
//  ProductListingSwiftUIApp
//
//  Created by Zeeshan Shakeel on 21/05/2025.
//

import SwiftUI
import ProductServiceKit

@main
struct ProductListingSwiftUIAppApp: App {
    var body: some Scene {
        WindowGroup {
            ProductListingView(viewModel: ProductListViewModel.init(productService: nil))
        }
    }
}
