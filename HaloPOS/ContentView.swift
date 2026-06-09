//
//  ContentView.swift
//  HaloPOS
//
//  Created by Amelia Putri Oktaviani on 07/06/2026.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var vm = POSViewModel(service: ProductService())
    
    var body: some View {
        VStack(spacing: 8) {
            ProductGridView(product: vm.product) { product in
                vm.addToCart(product)
            }
            
            CartView(cart: vm.cart) { cart in
                vm.increaseQuantity(for: cart)
            } onDecrease: { cart in
                vm.decreaseQuantity(for: cart)
            } onDelete: { cart in
                vm.deleteItem(cart)
            }
            
            VStack {
                Text("Total: Rp \(Int(vm.totalPrice))")
                    .font(.title2)
                    .bold()
                    .padding()
                
                if !vm.cart.isEmpty {
                    SwipeToPayButton(totalPrice: Int(vm.totalPrice)) {
                        vm.checkout()
                    }
                    .transition(.opacity.combined(with: .move(edge: .bottom)))
                }
            }
        }
        .fullScreenCover(item: $vm.currentTransaction) { transaction in
            TransactionDetailView(transaction: transaction) {
                vm.clearCart()
            }
        }
    }
}

#Preview {
    ContentView()
}
