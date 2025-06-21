//
//  ProductListViewModel.swift
//  ProductUIKitApp
//
//  Created by Zeeshan Shakeel on 15/05/2025.
//

import Foundation
import ProductServiceKit

class ProductListViewModel: ObservableObject, IProductListViewModel {
    private let productService: IProductService?
    
    @Published var products: [Product] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private var currentPage = 0
    private let limit = 10
    private var canLoadMore = true
    
    
    required init(productService: IProductService?) {
        self.productService = productService ?? ProductService(baseURLString: AppConstants.API.baseURLString, productEndPoint: AppConstants.API.productsEndpoint, session: URLSession.shared)
    }
    
    @MainActor
    func loadProducts() async {
        guard let productService = self.productService, self.productService != nil else {
            errorMessage = "Product service not available"
            return
        }
        guard !isLoading else {return}
        
        isLoading = true
        
        let skipValue = currentPage * limit
        
        do {
            let productResonse = try await productService.fetchProducts(skip: skipValue, limit: limit)
            
            if productResonse.products.isEmpty {
                self.canLoadMore = false
            } else {
                self.products.append(contentsOf: productResonse.products)
                self.currentPage += 1
            }
        } catch {
            self.errorMessage = error.localizedDescription
            print(error.localizedDescription)
        }
        self.isLoading = false
    }
    
    @MainActor
    func loadMoreProducts() async {
        await loadProducts()
    }
    
    func product(at index: Int) -> Product? {
        guard index >= 0 && index < products.count else { return nil }

        return products[index]
    }
    
    var numberOfProducts: Int {
        return products.count
    }
}
