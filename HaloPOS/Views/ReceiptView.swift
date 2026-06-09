//
//  ReceiptView.swift
//  HaloPOS
//
//  Created by Amelia Putri Oktaviani on 08/06/2026.
//

import SwiftUI

struct ReceiptView: View {
    let transaction: Transaction
    
    private var dateFormatter: DateFormatter {
        let df = DateFormatter()
        df.dateStyle = .medium
        df.timeStyle = .short
        df.locale = Locale(identifier: "id_ID")
        return df
    }
    
    var body: some View {
        VStack(spacing: 4) {
            // Header
            Text("HALO POS")
                .font(.system(size: 14, weight: .bold, design: .monospaced))
            Text("Struk Pembayaran")
                .font(.system(size: 10, design: .monospaced))
            
            dashedLine
            
            // Info transaksi
            VStack(alignment: .leading, spacing: 2) {
                infoRow(label: "No", value: transaction.receiptNumber)
                infoRow(label: "Tgl", value: dateFormatter.string(from: transaction.date))
            }
            
            dashedLine
            
            // Items
            VStack(spacing: 4) {
                ForEach(transaction.items) { item in
                    VStack(alignment: .leading, spacing: 0) {
                        Text(item.product.name)
                            .font(.system(size: 10, design: .monospaced))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HStack {
                            Text("\(item.quantity) x Rp \(Int(item.product.price))")
                                .font(.system(size: 10, design: .monospaced))
                            Spacer()
                            Text("Rp \(Int(item.product.price * Double(item.quantity)))")
                                .font(.system(size: 10, design: .monospaced))
                        }
                    }
                }
            }
            
            dashedLine
            
            // Total
            HStack {
                Text("TOTAL")
                    .font(.system(size: 12, weight: .bold, design: .monospaced))
                Spacer()
                Text("Rp \(Int(transaction.totalPrice))")
                    .font(.system(size: 12, weight: .bold, design: .monospaced))
            }
            
            dashedLine
            
            // Footer
            Text("Terima kasih!")
                .font(.system(size: 10, design: .monospaced))
                .padding(.top, 4)
        }
        .padding(12)
        .frame(width: 220)
        .background(.white)
        .foregroundStyle(.black)
    }
    
    private var dashedLine: some View {
        Text(String(repeating: "-", count: 32))
            .font(.system(size: 10, design: .monospaced))
            .lineLimit(1)
    }
    
    private func infoRow(label: String, value: String) -> some View {
        HStack(alignment: .top) {
            Text("\(label)")
                .font(.system(size: 10, design: .monospaced))
                .frame(width: 30, alignment: .leading)
            Text(": \(value)")
                .font(.system(size: 10, design: .monospaced))
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    ReceiptView(transaction: Transaction(
            items: [
                CartItem(product: Product(name: "Coca Cola", price: 5000), quantity: 2),
                CartItem(product: Product(name: "Mineral", price: 3000), quantity: 1)
            ],
            totalPrice: 13000
        ))
}
