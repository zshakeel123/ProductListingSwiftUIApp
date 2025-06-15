//
//  IProductListViewModel.swift
//  ProductListingSwiftUIApp
//
//  Created by Zeeshan Shakeel on 09/06/2025.
//

import Foundation
import ProductServiceKit

protocol IProductListViewModel : ObservableObject {
    var products: [Product] { get }
    var isLoading : Bool { get }
    var errorMessage: String? { get set }
 
    init(productService: IProductService?)
    func loadProducts()
    func loadMoreProducts()
}
