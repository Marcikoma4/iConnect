//
//  MatchScreen.swift
//  iConnect
//
//  Created by Marcell Halmai on 19/11/2026.
//

import SwiftUI

struct StudentMatchScreen: View {
    
    @Environment(AppData.self) private var appData
    @Binding var connectionType: AppData.ConnectionType
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    StudentMatchScreen(connectionType: .constant(.studentConnect))
        .environment(AppData())
}
