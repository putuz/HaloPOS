//
//  TransactionDetailView.swift
//  HaloPOS
//
//  Created by Amelia Putri Oktaviani on 08/06/2026.
//

import SwiftUI

struct TransactionDetailView: View {
    let transaction: Transaction
    let onDone: () -> Void
    
    private var dateFormatter: DateFormatter {
        let df = DateFormatter()
        df.dateStyle = .medium
        df.timeStyle = .short
        df.locale = Locale(identifier: "id_ID")
        return df
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                ScrollView {
                    VStack(spacing: 16) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 56))
                            .foregroundStyle(.green)
                        
                        Text("Pembayaran Berhasil")
                            .font(.title2)
                            .bold()
                        
                        Text(dateFormatter.string(from: transaction.date))
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.top)
                    
                    Divider()
                    
                    VStack(spacing: 8) {
                        ForEach(transaction.items) { item in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.product.name)
                                        .font(.subheadline)
                                    Text("x\(item.quantity)")
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                                Spacer()
                                Text("Rp \(Int(item.product.price * Double(item.quantity)))")
                                    .font(.subheadline)
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    Divider()
                    
                    HStack {
                        Text("Total")
                            .font(.headline)
                        Spacer()
                        Text("Rp \(Int(transaction.totalPrice))")
                            .font(.headline)
                            .bold()
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                }
                .background(Color(.systemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .shadow(color: .black.opacity(0.08), radius: 8, x: 0, y: 2)
                .padding()
            }
            
            VStack {
                Button {
                    printReceipt()
                } label: {
                    Label("Print Struk", systemImage: "printer")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                
                Button {
                    onDone()
                } label: {
                    Text("Selesai")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(.systemGray5))
                        .foregroundStyle(.primary)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }
            .padding()
        }
        .navigationTitle("Detail Transaksi")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func printReceipt() {
        let receiptView = ReceiptView(transaction: transaction)
        let renderer = ImageRenderer(content: receiptView)
        renderer.scale = 3.0 // resolusi tinggi untuk print
        
        guard let image = renderer.uiImage else { return }
        
        let printInfo = UIPrintInfo(dictionary: nil)
        printInfo.jobName = "Struk \(transaction.receiptNumber)"
        printInfo.outputType = .photo
        
        let controller = UIPrintInteractionController.shared
        controller.printInfo = printInfo
        controller.printingItem = image
        controller.showsNumberOfCopies = false
        controller.present(animated: true)
    }
}

#Preview {
    TransactionDetailView(transaction: Transaction(items: [
        CartItem(product: Product(name: "Coca Cola", price: 5000), quantity: 2),
        CartItem(product: Product(name: "Mineral", price: 3000), quantity: 1)
        
    ], totalPrice: 13000), onDone: {} )
}
