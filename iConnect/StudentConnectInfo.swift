//
//  StudentConnectInfo.swift
//  iConnect
//
//  Created by Marcell Halmai on 19/11/2026.
//

import SwiftUI

struct StudentConnectInfo: View {
    
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
                            
                            Text("Student connect")
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
                                        Image(systemName: "person.2")
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
                        Text("What is Student connect?")
                            .rockwellFont(18).bold()
                            .foregroundStyle(.primary)
                        
                        Text("Student connect pairs international and home students of the same or similar heritage and origin. It’s designed to reduce the risk of international students feeling isolated at university and to help ease the language barrier when settling into life in Bristol.")
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
                            symbol: "globe.europe.africa",
                            title: "Shared heritage & language",
                            detail: "Connect one-to-one with a fellow student from a similar cultural or linguistic background."
                        )
                        
                        highlightRow(
                            symbol: "cup.and.saucer",
                            title: "Flexible meetups",
                            detail: "Arrange casual meetups privately at times and places that suit you both."
                        )
                        
                        highlightRow(
                            symbol: "heart",
                            title: "Feel at home",
                            detail: "Build a friendly support network and ease the transition into university life."
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
    StudentConnectInfo()
}
