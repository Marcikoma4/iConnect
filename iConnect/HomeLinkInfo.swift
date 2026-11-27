//
//  HomeLinkInfo.swift
//  iConnect
//
//  Created by Marcell Halmai on 19/11/2026.
//

import SwiftUI

struct HomeLinkInfo: View {
    
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
                            
                            Text("Home link")
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
                                        Image(systemName: "house")
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
                        Text("What is Home link?")
                            .rockwellFont(18).bold()
                            .foregroundStyle(.primary)
                        
                        Text("HomeLink connects you with a small ‘family’ of students who share the same or similar heritage, led and managed by a University of Bristol staff member. Your group meets together on a regular basis to help make Bristol feel more like home.")
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
                            symbol: "person.3",
                            title: "Staff-managed family",
                            detail: "A member of university staff hosts and guides a small group of students with similar heritage."
                        )
                        
                        highlightRow(
                            symbol: "calendar",
                            title: "Regular group meetups",
                            detail: "Get together as a family on a recurring basis throughout the term."
                        )
                        
                        highlightRow(
                            symbol: "building.columns",
                            title: "Supportive community",
                            detail: "A welcoming space to share experiences, ask questions and build lasting friendships."
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
    HomeLinkInfo()
}
