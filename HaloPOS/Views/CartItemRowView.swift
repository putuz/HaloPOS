//
//  CartRow.swift
//  HaloPOS
//
//  Created by Amelia Putri Oktaviani on 07/06/2026.
//

import SwiftUI

struct CartItemRowView: View {
    
    let item: CartItem
    let onIncrease: () -> Void
    let onDecrease: () -> Void
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.product.name)
                
                Text("Rp \(Int(item.product.price))")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            
            Button {
                onDecrease()
                print("kurang")
            } label: {
                Image(systemName: "minus.circle")
                    .font(.title2)
            }
            .frame(width: 44, height: 44)
            .buttonStyle(.borderless)
            
            Text("\(item.quantity)")
                .frame(minWidth: 30)
            
            Button {
                onIncrease()
                print("tambah")
            } label: {
                Image(systemName: "plus.circle")
                    .font(.title2)
            }
            .frame(width: 44, height: 44)
            .buttonStyle(.borderless)
        }
    }
}

#Preview {
    CartItemRowView(item: CartItem(product: Product(name: "Coca Cola", price: 5000), quantity: 1), onIncrease: {}, onDecrease: {})
}
