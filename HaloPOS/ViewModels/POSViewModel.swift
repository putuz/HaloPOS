//
//  POSViewModel.swift
//  HaloPOS
//
//  Created by Amelia Putri Oktaviani on 07/06/2026.
//

import Foundation


final class POSViewModel: ObservableObject {
    
    @Published var product: [Product] = []
    @Published var cart: [CartItem] = []
    @Published var currentTransaction: Transaction? = nil
    
    private let service: ProductServiceProtocol
    
    init(service: ProductServiceProtocol) {
        self.service = service
        loadProduct()
    }
    
    func loadProduct() {
        product = service.fetchProducts()
    }
    
    func addToCart(_ product: Product) {
        if let index = cart.firstIndex(where: { $0.product.id == product.id }) {
            cart[index].quantity += 1
        } else {
            let item = CartItem(product: product, quantity: 1)
            cart.append(item)
        }
    }
    
    func increaseQuantity(for item: CartItem) {
        guard let index = cart.firstIndex(where: {
            $0.id == item.id
        }) else { return }
        
        cart[index].quantity += 1
    }
    
    func decreaseQuantity(for item: CartItem) {
        guard let index = cart.firstIndex(where: {
            $0.id == item.id
        }) else { return }
        
        if cart[index].quantity > 1 {
            cart[index].quantity -= 1
        } else {
            cart.remove(at: index)
        }
    }
    
    func deleteItem(_ item: CartItem) {
        cart.removeAll {
            $0.id == item.id
        }
    }
    
    func checkout() {
        let transaction = Transaction(items: cart, totalPrice: totalPrice)
        currentTransaction = transaction
    }
    
    func clearCart() {
        cart = []
        currentTransaction = nil
    }
    
    var totalPrice: Double {
        var total: Double = 0
        
        for item in cart {
            let subtotal = item.product.price * Double(item.quantity)
            
            total += subtotal
        }
        
        return total
    }
}
