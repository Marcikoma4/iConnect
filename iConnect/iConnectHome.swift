//
//  iConnectHome.swift
//  iConnect
//
//  Created by Marcell Halmai on 22/11/2026.
//

import SwiftUI

struct iConnectHome: View {
    
    @State private var tapped = false
    @Environment(AppData.self) private var appData
    @Binding var progress: AppData.Progress?
    
    private let brandRed = Color(red: 0.65, green: 0.09, blue: 0.19)
    private let subtitleColor = Color(white: 0.40)
    
    var body: some View {
        VStack(spacing: 0) {
            MonthHeader()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 22) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Belong at Bristol")
                            .rockwellFont(12).bold()
                            .foregroundStyle(brandRed)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("New Connections")
                                .rockwellFont(28).bold()
                            Text("A place to belong")
                                .rockwellFont(28).bold()
                                .foregroundStyle(brandRed)
                        }
                    }
                    .padding(.top, 16)
                    
                    VStack(spacing: 12) {
                        featureRow(
                            symbol: "person.2",
                            title: "Student connect",
                            description: "Connect with home students who speak your language."
                        )
                        
                        featureRow(
                            symbol: "house",
                            title: "Home link",
                            description: "Join a family scheme led by a member of staff of your nationality."
                        )
                        
                        featureRow(
                            symbol: "envelope",
                            title: "Pen & pal",
                            description: "Become pen pals with another student at the university."
                        )
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                .padding(.bottom, 12)
            }
            
            Button {
                tapped.toggle()
                progress = .profile
            } label: {
                HStack {
                    Text("Create profile")
                        .rockwellFont(22)
                    Spacer()
                    Image(systemName: "arrow.right")
                        .font(.system(size: 20, weight: .semibold))
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.horizontal, 20)
            }
            .buttonStyle(.custom(variant: .regular))
            .frame(height: 115)
            .padding(.horizontal, 20)
            .padding(.top, 8)
            .padding(.bottom, 6)
            .sensoryFeedback(.success, trigger: tapped)
            
            CustomTabBar()
        }
    }
    
    private func featureRow(symbol: String, title: String, description: String) -> some View {
        HStack(alignment: .top, spacing: 14) {
            Circle()
                .fill(brandRed.opacity(0.10))
                .frame(width: 42, height: 42)
                .overlay {
                    Image(systemName: symbol)
                        .font(.system(size: 17, weight: .medium))
                        .foregroundStyle(brandRed)
                }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .rockwellFont(16).bold()
                    .foregroundStyle(.primary)
                
                Text(description)
                    .rockwellFont(14)
                    .foregroundStyle(subtitleColor)
                    .fixedSize(horizontal: false, vertical: true)
                    .lineSpacing(2)
            }
            
            Spacer(minLength: 0)
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(brandRed.opacity(0.05))
        )
    }
}

#Preview {
    iConnectHome(progress: .constant(.home))
        .environment(AppData())
}
