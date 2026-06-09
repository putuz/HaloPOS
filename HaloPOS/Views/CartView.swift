//
//  CartView.swift
//  HaloPOS
//
//  Created by Amelia Putri Oktaviani on 08/06/2026.
//

import SwiftUI

struct CartView: View {
    let cart: [CartItem]
    
    let onIncrease: (CartItem) -> Void
    let onDecrease: (CartItem) -> Void
    let onDelete: (CartItem) -> Void
    
    var body: some View {
        List {
            Section("Cart") {
                ForEach(cart) { cart in
                    CartItemRowView(item: cart) {
                        onIncrease(cart)
                    } onDecrease: {
                        onDecrease(cart)
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            onDelete(cart)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    CartView(cart: [
        CartItem(product: Product(name: "Coca Cola", price: 5000), quantity: 5),
        CartItem(product: Product(name: "Mineral", price: 3000), quantity: 2)
    ], onIncrease: {_ in}, onDecrease: {_ in}, onDelete: {_ in})
}
