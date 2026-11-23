//
//  iConnectOverview.swift
//  iConnect
//
//  Created by Marcell Halmai on 22/11/2026.
//

import SwiftUI

struct iConnectOverview: View {
    
    @Environment(AppData.self) private var appData
    @Binding var progress: AppData.Progress?
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    iConnectOverview(progress: .constant(.overview))
        .environment(AppData())
}
