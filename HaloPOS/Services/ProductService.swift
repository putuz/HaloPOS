//
//  ProductService.swift
//  HaloPOS
//
//  Created by Amelia Putri Oktaviani on 07/06/2026.
//

import Foundation

final class ProductService: ProductServiceProtocol {
    
    func fetchProducts() -> [Product] {
        [
            Product(name: "Coca Cola", price: 5000),
            Product(name: "Mie Goreng", price: 10000),
            Product(name: "Kopi", price: 6000),
            Product(name: "Air Mineral", price: 3500),
            Product(name: "Pancong", price: 6000),
            Product(name: "Tempe Goreng", price: 1000),
            Product(name: "Tahu Goreng", price: 1000),
            Product(name: "Bakwan", price: 1000),
        ]
    }
}
