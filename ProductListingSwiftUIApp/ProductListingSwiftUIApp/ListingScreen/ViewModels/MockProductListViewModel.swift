//
//  MockProductListViewModel.swift
//  ProductListingSwiftUIApp
//
//  Created by Zeeshan Shakeel on 09/06/2025.
//

import Foundation
import SwiftUI

class MockProductListViewModel: ObservableObject, IProductListViewModel {
    @Published var products: [Product] = []
    
    @Published var isLoading: Bool = false
    
    @Published var errorMessage: String? = nil
    
    required init(productService: IProductService? = nil) {
        
    }
    
    func loadProducts() {
        self.isLoading = true
        
        // Simulate a delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            guard let self = self else { return }
            
            self.isLoading = false
            
            self.products = [
                Product(
                    id: 1,
                    title: "Essence Mascara Lash Princess",
                    description: "The Essence Mascara Lash Princess is a popular mascara known for its volumizing and lengthening effects. Achieve dramatic lashes with this long-lasting and cruelty-free formula.",
                    price: 9.99,
                    discountPercentage: 10.48,
                    rating: 2.56,
                    stock: 99,
                    brand: "Essence",
                    category: "beauty",
                    thumbnail: "https://cdn.dummyjson.com/product-images/beauty/essence-mascara-lash-princess/thumbnail.webp",
                    images: ["https://cdn.dummyjson.com/product-images/beauty/essence-mascara-lash-princess/1.webp"]
                ),
                Product(
                    id: 2,
                    title: "Eyeshadow Palette with Mirror",
                    description: "The Eyeshadow Palette with Mirror offers a versatile range of eyeshadow shades for creating stunning eye looks. With a built-in mirror, it's convenient for on-the-go makeup application.",
                    price: 19.99,
                    discountPercentage: 18.19,
                    rating: 2.86,
                    stock: 34,
                    brand: "Glamour Beauty",
                    category: "beauty",
                    thumbnail: "https://cdn.dummyjson.com/product-images/beauty/eyeshadow-palette-with-mirror/thumbnail.webp",
                    images: ["https://cdn.dummyjson.com/product-images/beauty/eyeshadow-palette-with-mirror/1.webp"]
                ),
                Product(
                    id: 3,
                    title: "Powder Canister",
                    description: "The Powder Canister is a finely milled setting powder designed to set makeup and control shine. With a lightweight and translucent formula, it provides a smooth and matte finish.",
                    price: 14.99,
                    discountPercentage: 9.84,
                    rating: 4.64,
                    stock: 89,
                    brand: "Velvet Touch",
                    category: "beauty",
                    thumbnail: "https://cdn.dummyjson.com/product-images/beauty/powder-canister/thumbnail.webp",
                    images: ["https://cdn.dummyjson.com/product-images/beauty/powder-canister/1.webp"]
                ),
                Product(
                    id: 4,
                    title: "Red Lipstick",
                    description: "The Red Lipstick is a classic and bold choice for adding a pop of color to your lips. With a creamy and pigmented formula, it provides a vibrant and long-lasting finish.",
                    price: 12.99,
                    discountPercentage: 12.16,
                    rating: 4.36,
                    stock: 91,
                    brand: "Chic Cosmetics",
                    category: "beauty",
                    thumbnail: "https://cdn.dummyjson.com/product-images/beauty/red-lipstick/thumbnail.webp",
                    images: ["https://cdn.dummyjson.com/product-images/beauty/red-lipstick/1.webp"]
                ),
                Product(
                    id: 5,
                    title: "Red Nail Polish",
                    description: "The Red Nail Polish offers a rich and glossy red hue for vibrant and polished nails. With a quick-drying formula, it provides a salon-quality finish at home.",
                    price: 8.99,
                    discountPercentage: 11.44,
                    rating: 4.32,
                    stock: 79,
                    brand: "Nail Couture",
                    category: "beauty",
                    thumbnail: "https://cdn.dummyjson.com/product-images/beauty/red-nail-polish/thumbnail.webp",
                    images: ["https://cdn.dummyjson.com/product-images/beauty/red-nail-polish/1.webp"]
                ),
                Product(
                    id: 6,
                    title: "Calvin Klein CK One",
                    description: "CK One by Calvin Klein is a classic unisex fragrance, known for its fresh and clean scent. It's a versatile fragrance suitable for everyday wear.",
                    price: 49.99,
                    discountPercentage: 1.89,
                    rating: 4.37,
                    stock: 29,
                    brand: "Calvin Klein",
                    category: "fragrances",
                    thumbnail: "https://cdn.dummyjson.com/product-images/fragrances/calvin-klein-ck-one/thumbnail.webp",
                    images: [
                        "https://cdn.dummyjson.com/product-images/fragrances/calvin-klein-ck-one/1.webp",
                        "https://cdn.dummyjson.com/product-images/fragrances/calvin-klein-ck-one/2.webp",
                        "https://cdn.dummyjson.com/product-images/fragrances/calvin-klein-ck-one/3.webp"
                    ]
                ),
                Product(
                    id: 7,
                    title: "Chanel Coco Noir Eau De",
                    description: "Coco Noir by Chanel is an elegant and mysterious fragrance, featuring notes of grapefruit, rose, and sandalwood. Perfect for evening occasions.",
                    price: 129.99,
                    discountPercentage: 16.51,
                    rating: 4.26,
                    stock: 58,
                    brand: "Chanel",
                    category: "fragrances",
                    thumbnail: "https://cdn.dummyjson.com/product-images/fragrances/chanel-coco-noir-eau-de/thumbnail.webp",
                    images: [
                        "https://cdn.dummyjson.com/product-images/fragrances/chanel-coco-noir-eau-de/1.webp",
                        "https://cdn.dummyjson.com/product-images/fragrances/chanel-coco-noir-eau-de/2.webp",
                        "https://cdn.dummyjson.com/product-images/fragrances/chanel-coco-noir-eau-de/3.webp"
                    ]
                )
            ]
        }
    }
    
    func loadMoreProducts() {
        self.isLoading = true
        
        let moreProducts:[Product] = [
            Product(
                id: 8,
                title: "Dior J'adore",
                description: "J'adore by Dior is a luxurious and floral fragrance, known for its blend of ylang-ylang, rose, and jasmine. It embodies femininity and sophistication.",
                price: 89.99,
                discountPercentage: 14.72,
                rating: 3.8,
                stock: 98,
                brand: "Dior",
                category: "fragrances",
                thumbnail: "https://cdn.dummyjson.com/product-images/fragrances/dior-j'adore/thumbnail.webp",
                images: [
                    "https://cdn.dummyjson.com/product-images/fragrances/dior-j'adore/1.webp",
                    "https://cdn.dummyjson.com/product-images/fragrances/dior-j'adore/2.webp",
                    "https://cdn.dummyjson.com/product-images/fragrances/dior-j'adore/3.webp"
                ]
            ),
            Product(
                id: 9,
                title: "Dolce Shine Eau de",
                description: "Dolce Shine by Dolce & Gabbana is a vibrant and fruity fragrance, featuring notes of mango, jasmine, and blonde woods. It's a joyful and youthful scent.",
                price: 69.99,
                discountPercentage: 0.62,
                rating: 3.96,
                stock: 4,
                brand: "Dolce & Gabbana",
                category: "fragrances",
                thumbnail: "https://cdn.dummyjson.com/product-images/fragrances/dolce-shine-eau-de/thumbnail.webp",
                images: [
                    "https://cdn.dummyjson.com/product-images/fragrances/dolce-shine-eau-de/1.webp",
                    "https://cdn.dummyjson.com/product-images/fragrances/dolce-shine-eau-de/2.webp",
                    "https://cdn.dummyjson.com/product-images/fragrances/dolce-shine-eau-de/3.webp"
                ]
            ),
            Product(
                id: 10,
                title: "Gucci Bloom Eau de",
                description: "Gucci Bloom by Gucci is a floral and captivating fragrance, with notes of tuberose, jasmine, and Rangoon creeper. It's a modern and romantic scent.",
                price: 79.99,
                discountPercentage: 14.39,
                rating: 2.74,
                stock: 91,
                brand: "Gucci",
                category: "fragrances",
                thumbnail: "https://cdn.dummyjson.com/product-images/fragrances/gucci-bloom-eau-de/thumbnail.webp",
                images: [
                    "https://cdn.dummyjson.com/product-images/fragrances/gucci-bloom-eau-de/1.webp",
                    "https://cdn.dummyjson.com/product-images/fragrances/gucci-bloom-eau-de/2.webp",
                    "https://cdn.dummyjson.com/product-images/fragrances/gucci-bloom-eau-de/3.webp"
                ]
            ),
            Product(
                id: 11,
                title: "Annibale Colombo Bed",
                description: "The Annibale Colombo Bed is a luxurious and elegant bed frame, crafted with high-quality materials for a comfortable and stylish bedroom.",
                price: 1899.99,
                discountPercentage: 8.57,
                rating: 4.77,
                stock: 88,
                brand: "Annibale Colombo",
                category: "furniture",
                thumbnail: "https://cdn.dummyjson.com/product-images/furniture/annibale-colombo-bed/thumbnail.webp",
                images: [
                    "https://cdn.dummyjson.com/product-images/furniture/annibale-colombo-bed/1.webp",
                    "https://cdn.dummyjson.com/product-images/furniture/annibale-colombo-bed/2.webp",
                    "https://cdn.dummyjson.com/product-images/furniture/annibale-colombo-bed/3.webp"
                ]
            ),
            Product(
                id: 12,
                title: "Annibale Colombo Sofa",
                description: "The Annibale Colombo Sofa is a sophisticated and comfortable seating option, featuring exquisite design and premium upholstery for your living room.",
                price: 2499.99,
                discountPercentage: 14.4,
                rating: 3.92,
                stock: 60,
                brand: "Annibale Colombo",
                category: "furniture",
                thumbnail: "https://cdn.dummyjson.com/product-images/furniture/annibale-colombo-sofa/thumbnail.webp",
                images: [
                    "https://cdn.dummyjson.com/product-images/furniture/annibale-colombo-sofa/1.webp",
                    "https://cdn.dummyjson.com/product-images/furniture/annibale-colombo-sofa/2.webp",
                    "https://cdn.dummyjson.com/product-images/furniture/annibale-colombo-sofa/3.webp"
                ]
            ),
            Product(
                id: 13,
                title: "Bedside Table African Cherry",
                description: "The Bedside Table in African Cherry is a stylish and functional addition to your bedroom, providing convenient storage space and a touch of elegance.",
                price: 299.99,
                discountPercentage: 19.09,
                rating: 2.87,
                stock: 64,
                brand: "Furniture Co.",
                category: "furniture",
                thumbnail: "https://cdn.dummyjson.com/product-images/furniture/bedside-table-african-cherry/thumbnail.webp",
                images: [
                    "https://cdn.dummyjson.com/product-images/furniture/bedside-table-african-cherry/1.webp",
                    "https://cdn.dummyjson.com/product-images/furniture/bedside-table-african-cherry/2.webp",
                    "https://cdn.dummyjson.com/product-images/furniture/bedside-table-african-cherry/3.webp"
                ]
            ),
            Product(
                id: 14,
                title: "Knoll Saarinen Executive Conference Chair",
                description: "The Knoll Saarinen Executive Conference Chair is a modern and ergonomic chair, perfect for your office or conference room with its timeless design.",
                price: 499.99,
                discountPercentage: 2.01,
                rating: 4.88,
                stock: 26,
                brand: "Knoll",
                category: "furniture",
                thumbnail: "https://cdn.dummyjson.com/product-images/furniture/knoll-saarinen-executive-conference-chair/thumbnail.webp",
                images: [
                    "https://cdn.dummyjson.com/product-images/furniture/knoll-saarinen-executive-conference-chair/1.webp",
                    "https://cdn.dummyjson.com/product-images/furniture/knoll-saarinen-executive-conference-chair/2.webp",
                    "https://cdn.dummyjson.com/product-images/furniture/knoll-saarinen-executive-conference-chair/3.webp"
                ]
            )
        ]
        
        // Simulate a delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.isLoading = false
            
            self.products.append(contentsOf: moreProducts)
        }
    }
}
