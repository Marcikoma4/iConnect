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
    @State private var selectedLanguage: Language = .english
    
    enum Language: String, CaseIterable, Identifiable {
        case english, mandarin, spanish
        var id: Self { self }
    }
    
    var body: some View {
        MonthHeader()
        
        Text("Belong at Bristol")
            .rockwellFont(12)
            .foregroundStyle(Color(red: 0.65, green: 0.09, blue: 0.19))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 20)
            .padding(.top, 20)
        
        VStack {
            Text("New Connections")
                .rockwellFont(24).bold()
                .padding(.leading, 20)
                .padding(.top, 20)
            Text("A place to belong")
                .rockwellFont(24).bold()
                .padding(.leading, 20)
                .padding(.top, 20)
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        
        VStack{
            Text("Meet people, share experiences")
                .rockwellFont(15)
                .padding(.leading, 20)
            Text("and feel at home with iConnect")
                .rockwellFont(15)
                .padding(.leading, 20)
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        
        Form {
            Picker("Language", selection: $selectedLanguage) {
                ForEach(Language.allCases) { language in
                    Text(language.rawValue.capitalized)
                        .tag(language)
                }
            }
            .pickerStyle(.menu)
        }
        .scrollContentBackground(.hidden)
        
        Button {
            tapped.toggle()
        } label: {
            HStack {
                Text("Create profile")
                    .rockwellFont(30)
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.leading, 20)
        }
        .padding(10)
        .buttonStyle(.custom(variant: .regular))
        .frame(height: 125)
        .sensoryFeedback(.success, trigger: tapped)
        
        
        CustomTabBar()
        
    }
}

#Preview {
    iConnectHome(progress: .constant(.home))
        .environment(AppData())
}
