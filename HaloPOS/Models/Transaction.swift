//
//  Transaction.swift
//  HaloPOS
//
//  Created by Amelia Putri Oktaviani on 08/06/2026.
//

import Foundation

struct Transaction: Identifiable {
    let id: UUID
    let receiptNumber: String
    let items: [CartItem]
    let totalPrice: Double
    let date: Date
    
    init(items: [CartItem], totalPrice: Double) {
        self.id = UUID()
        self.date = Date()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd-HHmmss"
        self.receiptNumber = "TRX-\(formatter.string(from: self.date))"
        
        self.items = items
        self.totalPrice = totalPrice
        
        
    }
}
