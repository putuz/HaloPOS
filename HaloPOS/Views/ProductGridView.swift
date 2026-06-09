//
//  ProductGridView.swift
//  HaloPOS
//
//  Created by Amelia Putri Oktaviani on 08/06/2026.
//

import SwiftUI

struct ProductGridView: View {
    
    let product: [Product]
    let onSelect: (Product) -> Void
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(product) { product in
                    ProductCardView(product: product) {
                        onSelect(product)
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    ProductGridView(product: [Product(name: "Mineral", price: 10000)], onSelect: {_ in})
}
