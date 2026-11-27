//
//  FamilyMatchScreen.swift
//  iConnect
//
//  Created by Marcell Halmai on 19/11/2026.
//

import SwiftUI
import MessageUI

struct FamilyMatchScreen: View {
    
    @Environment(AppData.self) private var appData
    @Binding var connectionType: AppData.ConnectionType
    @Binding var progress: AppData.Progress?
    
    @State private var tapped = false
    @State private var showingEmailSheet = false
    @State private var showingMailUnavailableAlert = false
    
    private let brandRed = Color(red: 0.65, green: 0.09, blue: 0.19)
    private let labelColor = Color(white: 0.42)
    
    private let hostName = "Dr Jane Doe"
    private let hostEmail = "janedoe@bristol.ac.uk"
    
    private var matchNationality: String {
        appData.language
    }
    
    private var familyStudents: [(name: String, course: String, year: String)] {
        [
            ("John Doe", "Physics", "Year 1"),
            ("Jane Doe", "Finance", "Year 2")
        ]
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                MonthHeader()
                Button {
                    tapped.toggle()
                    progress = .overview
                } label: {
                    Text("Back")
                }
                .padding(.trailing, 25)
                .buttonStyle(.glass)
                .controlSize(.large)
                .sensoryFeedback(.success, trigger: tapped)
            }
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("It’s a match!")
                        .rockwellFont(26).bold()
                        .padding(.top, 16)
                    
                    // Hero HomeLink banner
                    ZStack {
                        VStack(alignment: .leading) {
                            Text("Your HomeLink family")
                                .rockwellFont(21).bold()
                                .foregroundStyle(.white)
                            Spacer()
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                        .padding(.top, 20)
                        .padding(.leading, 18)
                        .padding(.trailing, 110)
                        
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                Circle()
                                    .fill(.white)
                                    .frame(width: 82, height: 82)
                                    .overlay {
                                        Image(systemName: "person.2")
                                            .font(.system(size: 30, weight: .regular))
                                            .foregroundStyle(brandRed)
                                            .offset(y: -2)
                                    }
                                    .overlay(alignment: .bottomTrailing) {
                                        Circle()
                                            .fill(brandRed)
                                            .frame(width: 26, height: 26)
                                            .overlay {
                                                Image(systemName: "checkmark")
                                                    .font(.system(size: 12, weight: .bold))
                                                    .foregroundStyle(.white)
                                            }
                                            .offset(x: 4, y: -8)
                                    }
                                    .offset(y: 12)
                                    .padding(.trailing, 16)
                            }
                        }
                    }
                    .frame(height: 118)
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .fill(brandRed)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    
                    Text("Meet your staff host")
                        .rockwellFont(22).bold()
                        .padding(.top, 4)
                    
                    // Staff host card
                    VStack(alignment: .leading, spacing: 18) {
                        detailField(label: "STAFF MEMBER") {
                            Text(hostName)
                                .rockwellFont(20).bold()
                                .foregroundStyle(.primary)
                        }
                        
                        detailField(label: "NATIONALITY") {
                            Text(matchNationality)
                                .rockwellFont(16)
                                .foregroundStyle(.primary)
                        }
                        
                        detailField(label: "EMAIL") {
                            Button {
                                openEmailComposer()
                            } label: {
                                Text(hostEmail)
                                    .rockwellFont(15)
                                    .foregroundStyle(brandRed)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(20)
                    .background(
                        RoundedRectangle(cornerRadius: 14, style: .continuous)
                            .fill(brandRed.opacity(0.05))
                    )
                    
                    Text("Other students in your family")
                        .rockwellFont(19).bold()
                        .padding(.top, 4)
                    
                    // Other students card
                    VStack(alignment: .leading, spacing: 0) {
                        ForEach(Array(familyStudents.enumerated()), id: \.offset) { index, student in
                            VStack(alignment: .leading, spacing: 4) {
                                Text(student.name)
                                    .rockwellFont(16).bold()
                                    .foregroundStyle(.primary)
                                
                                Text("\(matchNationality) · \(student.course) · \(student.year)")
                                    .rockwellFont(13)
                                    .foregroundStyle(labelColor)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.vertical, 12)
                            
                            if index < familyStudents.count - 1 {
                                Divider()
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 6)
                    .background(
                        RoundedRectangle(cornerRadius: 14, style: .continuous)
                            .fill(brandRed.opacity(0.05))
                    )
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 12)
            }
            
            Button {
                tapped.toggle()
                openEmailComposer()
            } label: {
                HStack {
                    Text("Email your staff host")
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
        .onAppear {
            appData.hasConnected = true
        }
        .sheet(isPresented: $showingEmailSheet) {
            SCEmailView(recipient: hostEmail, recipientFirstName: "Dr Doe", greeting: "Dear")
        }
        .alert("Mail Unavailable", isPresented: $showingMailUnavailableAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Mail is not configured on this device. You can email \(hostName) at \(hostEmail).")
        }
    }
    
    @ViewBuilder
    private func detailField<Content: View>(label: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(label)
                .rockwellFont(11).bold()
                .tracking(0.8)
                .foregroundStyle(labelColor)
            
            content()
        }
    }
    
    private func openEmailComposer() {
        if MFMailComposeViewController.canSendMail() {
            showingEmailSheet = true
        } else {
            showingMailUnavailableAlert = true
        }
    }
}

#Preview {
    FamilyMatchScreen(connectionType: .constant(.homeLink), progress: .constant(.matchScreen))
        .environment(AppData())
}
