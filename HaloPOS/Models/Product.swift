//
//  Product.swift
//  HaloPOS
//
//  Created by Amelia Putri Oktaviani on 07/06/2026.
//

import Foundation

struct Product: Identifiable {
    let id = UUID()
    let name: String
    let price: Double
}
