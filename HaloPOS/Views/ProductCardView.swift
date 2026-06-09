//
//  ProductRow.swift
//  HaloPOS
//
//  Created by Amelia Putri Oktaviani on 07/06/2026.
//

import SwiftUI

struct ProductCardView: View {
    
    let product: Product
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            VStack(spacing: 8) {
                Image(systemName: "cart")
                    .font(.largeTitle)
                
                Text(product.name)
                
                Text("Rp \(Int(product.price))")
                    .font(.caption)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 120)
            .background(.thinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    ProductCardView(product: Product(name: "Coca Cola", price: 5000), action: {
        print("Add Tapped")
    })
}
