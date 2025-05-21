//
//  ProductListViewModel.swift
//  ProductUIKitApp
//
//  Created by Zeeshan Shakeel on 15/05/2025.
//

import Foundation

class ProductListViewModel: ObservableObject {
    private let productService: IProductService
    
    @Published var products: [Product] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private var currentPage = 0
    private let limit = 10
    private var canLoadMore = true
    
    
    init(productService: IProductService = ProductService()) {
        self.productService = productService
    }
    
    func loadProducts() {
        guard !isLoading else {return}
        isLoading = true
        
        let skipValue = currentPage * limit
        
        productService.fetchProducts(skip: skipValue, limit: limit) { [weak self] result in
            guard let self = self else {return}
            
            DispatchQueue.main.async {
                self.isLoading = false
                
                switch result {
                case .success(let productResponse):
                    if productResponse.products.isEmpty {
                        self.canLoadMore = false // No more products to load
                    } else {
                        self.products.append(contentsOf: productResponse.products)
                        self.currentPage += 1
                    }
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func loadMoreProducts() {
        loadProducts()
    }
    
    func product(at index: Int) -> Product? {
        guard index >= 0 && index < products.count else { return nil }

        return products[index]
    }
    
    var numberOfProducts: Int {
        return products.count
    }
}
