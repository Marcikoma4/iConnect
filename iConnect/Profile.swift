//
//  Profile.swift
//  iConnect
//
//  Created by Marcell Halmai on 19/11/2026.
//

import SwiftUI

struct Profile: View {
    
    @Environment(AppData.self) private var appData
    @Binding var progress: AppData.Progress?
    
    var body: some View {
        VStack {
            
        }
    }
}

#Preview {
    Profile(progress: .constant(.profile))
        .environment(AppData())
}
