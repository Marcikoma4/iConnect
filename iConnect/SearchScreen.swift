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
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    SearchScreen(progress: .constant(.searchScreen))
        .environment(AppData())
}
