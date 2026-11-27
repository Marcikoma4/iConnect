//
//  SearchScreen.swift
//  iConnect
//
//  Created by Marcell Halmai on 19/11/2026.
//

import SwiftUI

struct SearchScreen: View {
    
    @Environment(AppData.self) private var appData
    @Binding var progress: AppData.Progress?
    @Binding var connectionType: AppData.ConnectionType
    
    @State private var arcProgress: CGFloat = 0
    @State private var didComplete = false
    
    private let brandRed = Color(red: 0.65, green: 0.09, blue: 0.19)
    private let subtitleColor = Color(white: 0.42)
    
    private var centerSymbol: String {
        switch connectionType {
        case .studentConnect:
            "person.2"
        case .homeLink:
            "house"
        case .penPal:
            "envelope"
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            MonthHeader()
            
            VStack(alignment: .leading, spacing: 6) {
                Text("Finding your people")
                    .rockwellFont(26).bold()
                
                Text("We’re looking for someone you’ll click with.")
                    .rockwellFont(14)
                    .foregroundStyle(subtitleColor)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)
            .padding(.top, 16)
            
            Spacer()
            
            VStack(spacing: 28) {
                ZStack {
                    Circle()
                        .stroke(brandRed.opacity(0.06), lineWidth: 26)
                        .frame(width: 184, height: 184)
                    
                    Circle()
                        .trim(from: 0, to: arcProgress)
                        .stroke(
                            brandRed,
                            style: StrokeStyle(lineWidth: 4.5, lineCap: .round)
                        )
                        .frame(width: 184, height: 184)
                        .rotationEffect(.degrees(-90))
                    
                    Image(systemName: centerSymbol)
                        .font(.system(size: 50, weight: .light))
                        .foregroundStyle(brandRed)
                }
                
                VStack(spacing: 10) {
                    Text("Searching for a match...")
                        .rockwellFont(24).bold()
                        .multilineTextAlignment(.center)
                    
                    Text("Check your email for further details.\nWe’ll be in touch when your match is ready.")
                        .rockwellFont(14)
                        .foregroundStyle(subtitleColor)
                        .multilineTextAlignment(.center)
                        .lineSpacing(3)
                }
                .padding(.horizontal, 24)
            }
            
            Spacer()
            
            HStack(spacing: 14) {
                Image(systemName: "checkmark")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(brandRed)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Your profile has been submitted")
                        .rockwellFont(15).bold()
                        .foregroundStyle(.primary)
                    
                    Text("You can come back at any time.")
                        .rockwellFont(13)
                        .foregroundStyle(subtitleColor)
                }
                
                Spacer(minLength: 0)
            }
            .padding(.horizontal, 18)
            .padding(.vertical, 16)
            .background(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(brandRed.opacity(0.05))
            )
            .padding(.horizontal, 20)
            .padding(.bottom, 16)
            
            CustomTabBar()
        }
        .sensoryFeedback(.success, trigger: didComplete)
        .task {
            arcProgress = 0
            withAnimation(.easeInOut(duration: 3.0)) {
                arcProgress = 1.0
            }
            try? await Task.sleep(for: .seconds(3.0))
            guard !Task.isCancelled else { return }
            didComplete.toggle()
            try? await Task.sleep(for: .seconds(0.3))
            guard !Task.isCancelled else { return }
            progress = .matchScreen
        }
    }
}

#Preview {
    SearchScreen(
        progress: .constant(.searchScreen),
        connectionType: .constant(.studentConnect)
    )
    .environment(AppData())
}
