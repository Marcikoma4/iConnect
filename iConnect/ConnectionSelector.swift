//
//  ConnectionSelector.swift
//  iConnect
//
//  Created by Marcell Halmai on 19/11/2026.
//

import SwiftUI

struct ConnectionSelector: View {
    
    @State private var tapped = false
    @State private var activeInfo: InfoSheet?
    @Environment(AppData.self) private var appData
    @Binding var progress: AppData.Progress?
    @Binding var connectionType: AppData.ConnectionType
    
    private let brandRed = Color(red: 0.65, green: 0.09, blue: 0.19)
    private let subtitleColor = Color(white: 0.42)
    
    private enum InfoSheet: Identifiable {
        case studentConnect, homeLink, penPal
        var id: Self { self }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            MonthHeader()
            
            VStack(alignment: .leading, spacing: 6) {
                Text("Choose your connection")
                    .rockwellFont(26).bold()
                
                Text("Three ways to make Bristol feel like home.")
                    .rockwellFont(14)
                    .foregroundStyle(subtitleColor)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)
            .padding(.top, 16)
            .padding(.bottom, 14)
            
            ScrollView {
                VStack(spacing: 16) {
                    connectionCard(
                        title: "Student connect",
                        description: "Meet a fellow student with similar interests and make a global connection",
                        symbol: "person.2",
                        info: .studentConnect
                    ) {
                        selectConnection(.studentConnect)
                    }
                    
                    connectionCard(
                        title: "Home link",
                        description: "Connect with students and staff of your nationality to make Bristol feel more like home",
                        symbol: "house",
                        info: .homeLink
                    ) {
                        selectConnection(.homeLink)
                    }
                    
                    connectionCard(
                        title: "Pen & pal",
                        description: "Not up for meeting up in person? Find a pen pal from a different accommodation and learn a new language!",
                        symbol: "envelope",
                        info: .penPal
                    ) {
                        selectConnection(.penPal)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 4)
                .padding(.bottom, 16)
            }
            
            CustomTabBar()
        }
        .sheet(item: $activeInfo) { sheet in
            switch sheet {
            case .studentConnect:
                StudentConnectInfo()
            case .homeLink:
                HomeLinkInfo()
            case .penPal:
                PenPalInfo()
            }
        }
    }
    
    private func connectionCard(
        title: String,
        description: String,
        symbol: String,
        info: InfoSheet,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            ZStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text(title)
                        .rockwellFont(22).bold()
                        .foregroundStyle(.white)
                    
                    Text(description)
                        .rockwellFont(14)
                        .foregroundStyle(.white.opacity(0.92))
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    Spacer(minLength: 0)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding(.top, 20)
                .padding(.leading, 18)
                .padding(.trailing, 114)
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Circle()
                            .fill(.white)
                            .frame(width: 84, height: 84)
                            .overlay {
                                Image(systemName: symbol)
                                    .font(.system(size: 30, weight: .regular))
                                    .foregroundStyle(brandRed)
                                    .offset(y: -4)
                            }
                            .offset(y: 14)
                            .padding(.trailing, 16)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            // Counteract UoBButtonStyle's 55pt bottom padding so the card content
            // and bottom-clipped icon badge align cleanly to the full card height.
            .padding(.bottom, -55)
        }
        .buttonStyle(.custom(variant: .regular))
        .frame(height: 168)
        .sensoryFeedback(.success, trigger: tapped)
        .overlay(alignment: .topTrailing) {
            Button {
                activeInfo = info
            } label: {
                Image(systemName: "info.circle")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundStyle(.white)
                    .padding(14)
                    .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            .accessibilityLabel("\(title) info")
        }
    }
    
    private func selectConnection(_ type: AppData.ConnectionType) {
        connectionType = type
        tapped.toggle()
        progress = .searchScreen
    }
}

#Preview {
    ConnectionSelector(
        progress: .constant(.connectionSelector),
        connectionType: .constant(.studentConnect)
    )
    .environment(AppData())
}
