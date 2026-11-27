//
//  PenPalInfo.swift
//  iConnect
//
//  Created by Marcell Halmai on 19/11/2026.
//

import SwiftUI

struct PenPalInfo: View {
    
    @Environment(\.dismiss) private var dismiss
    
    private let brandRed = Color(red: 0.65, green: 0.09, blue: 0.19)
    private let subtitleColor = Color(white: 0.40)
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("About this connection")
                    .rockwellFont(13).bold()
                    .foregroundStyle(brandRed)
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Text("Done")
                        .rockwellFont(15).bold()
                        .foregroundStyle(brandRed)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            .padding(.bottom, 14)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Hero banner
                    ZStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("CONNECTION TYPE")
                                .rockwellFont(11).bold()
                                .tracking(0.8)
                                .foregroundStyle(.white.opacity(0.85))
                            
                            Text("Pen & pal")
                                .rockwellFont(24).bold()
                                .foregroundStyle(.white)
                            
                            Spacer()
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                        .padding(.top, 18)
                        .padding(.leading, 18)
                        .padding(.trailing, 106)
                        
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                Circle()
                                    .fill(.white)
                                    .frame(width: 78, height: 78)
                                    .overlay {
                                        Image(systemName: "envelope")
                                            .font(.system(size: 28, weight: .regular))
                                            .foregroundStyle(brandRed)
                                            .offset(y: -3)
                                    }
                                    .offset(y: 14)
                                    .padding(.trailing, 16)
                            }
                        }
                    }
                    .frame(height: 112)
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .fill(brandRed)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    
                    // Overview description
                    VStack(alignment: .leading, spacing: 8) {
                        Text("What is Pen & pal?")
                            .rockwellFont(18).bold()
                            .foregroundStyle(.primary)
                        
                        Text("Pen & pal is tailored for more introverted students — or anyone who prefers a quieter way to connect — who would rather correspond through physical letters sent via the mail than meet up in person.")
                            .rockwellFont(15)
                            .foregroundStyle(subtitleColor)
                            .lineSpacing(4)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(18)
                    .background(
                        RoundedRectangle(cornerRadius: 14, style: .continuous)
                            .fill(brandRed.opacity(0.05))
                    )
                    
                    // Key highlights
                    VStack(alignment: .leading, spacing: 14) {
                        Text("How it works")
                            .rockwellFont(18).bold()
                            .foregroundStyle(.primary)
                        
                        highlightRow(
                            symbol: "envelope.open",
                            title: "Physical letters by mail",
                            detail: "Exchange handwritten letters through the post rather than arranging face-to-face meetups."
                        )
                        
                        highlightRow(
                            symbol: "sparkles",
                            title: "No pressure to meet up",
                            detail: "Ideal for introverted students who enjoy thoughtful, low-pressure one-to-one connection."
                        )
                        
                        highlightRow(
                            symbol: "character.book.closed",
                            title: "Share stories & languages",
                            detail: "Get to know another student from a different accommodation and practise a language at your own pace."
                        )
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(18)
                    .background(
                        RoundedRectangle(cornerRadius: 14, style: .continuous)
                            .fill(brandRed.opacity(0.05))
                    )
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 24)
            }
        }
    }
    
    private func highlightRow(symbol: String, title: String, detail: String) -> some View {
        HStack(alignment: .top, spacing: 12) {
            Circle()
                .fill(brandRed.opacity(0.10))
                .frame(width: 36, height: 36)
                .overlay {
                    Image(systemName: symbol)
                        .font(.system(size: 15, weight: .medium))
                        .foregroundStyle(brandRed)
                }
            
            VStack(alignment: .leading, spacing: 3) {
                Text(title)
                    .rockwellFont(15).bold()
                    .foregroundStyle(.primary)
                
                Text(detail)
                    .rockwellFont(13)
                    .foregroundStyle(subtitleColor)
                    .lineSpacing(2)
            }
        }
    }
}

#Preview {
    PenPalInfo()
}
