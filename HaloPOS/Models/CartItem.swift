//
//  CartItem.swift
//  HaloPOS
//
//  Created by Amelia Putri Oktaviani on 07/06/2026.
//

import Foundation

struct CartItem: Identifiable {
    let id = UUID()
    let product: Product
    var quantity: Int
}
