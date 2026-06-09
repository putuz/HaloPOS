//
//  SwipeToPayButton.swift
//  HaloPOS
//
//  Created by Amelia Putri Oktaviani on 08/06/2026.
//

import SwiftUI

struct SwipeToPayButton: View {
    let totalPrice: Int
    let onSuccess: () -> Void
    
    @State private var offset: CGFloat = 0
    @State private var isPaid: Bool = false
    
    private let buttonHeight: CGFloat = 56
    private let trackWidth: CGFloat = 300
    private let thumbWidth: CGFloat = 56
    
    var body: some View {
        ZStack(alignment: .leading) {
            if isPaid {
                RoundedRectangle(cornerRadius: buttonHeight / 2)
                    .fill(Color.green)
                    .frame(width: trackWidth, height: buttonHeight)
                    .overlay {
                        HStack(spacing: 8) {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundStyle(.white)
                                .font(.title3)
                            Text("Pembayaran Berhasil!")
                                .font(.headline)
                                .foregroundStyle(.white)
                        }
                    }
                    .transition(.opacity.combined(with: .scale))
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                            onSuccess()
                            withAnimation(.easeInOut) {
                                isPaid = false
                                offset = 0
                            }
                        }
                    }
            } else {
                RoundedRectangle(cornerRadius: buttonHeight / 2)
                    .fill(Color.green.opacity(0.2))
                    .frame(width: trackWidth, height: buttonHeight)
                    .overlay {
                        Text("Geser untuk Bayar  →")
                            .font(.headline)
                            .foregroundStyle(.green.opacity(0.8))
                    }
                
                RoundedRectangle(cornerRadius: (buttonHeight - 8) / 2)
                    .fill(Color.green)
                    .frame(width: thumbWidth, height: buttonHeight - 8)
                    .overlay {
                        Image(systemName: "chevron.right.2")
                            .foregroundStyle(.white)
                            .font(.title3)
                            .bold()
                    }
                    .offset(x: offset + 4)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                let newOffset = min(max(value.translation.width, 0), trackWidth - thumbWidth - 8)
                                offset = newOffset
                            }
                            .onEnded { _ in
                                let threshold = trackWidth - thumbWidth - 8
                                if offset >= threshold * 0.9 {
                                    withAnimation(.spring) {
                                        isPaid = true
                                    }
                                } else {
                                    withAnimation(.spring) {
                                        offset = 0
                                    }
                                }
                            }
                    )
                    .transition(.opacity)
            }
        }
        .animation(.spring, value: isPaid)
    }
}

#Preview {
    SwipeToPayButton(totalPrice: 50000) {
        print("Pembayaran Berhasil")
    }
}
