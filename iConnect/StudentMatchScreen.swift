//
//  StudentMatchScreen.swift
//  iConnect
//
//  Created by Marcell Halmai on 19/11/2026.
//

import SwiftUI
import MessageUI

struct StudentMatchScreen: View {
    
    @Environment(AppData.self) private var appData
    @Binding var connectionType: AppData.ConnectionType
    @Binding var progress: AppData.Progress?
    
    @State private var tapped = false
    @State private var showingEmailSheet = false
    @State private var showingMailUnavailableAlert = false
    
    private let brandRed = Color(red: 0.65, green: 0.09, blue: 0.19)
    private let labelColor = Color(white: 0.42)
    
    private let matchName = "Carlos Mendoza"
    private let matchCourse = "Computer Science"
    private let matchYear = "Year 2"
    private let matchEmail = "carlos.mendoza@bristol.ac.uk"
    
    private var matchNationality: String {
        appData.language
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                MonthHeader()
                Button {
                    tapped.toggle()
                    progress = .overview
                } label : {
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
                    
                    // Hero connection banner
                    ZStack {
                        VStack(alignment: .leading) {
                            Text("Your Bristol connection")
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
                    
                    Text("Meet your match")
                        .rockwellFont(22).bold()
                        .padding(.top, 4)
                    
                    // Match details card
                    VStack(alignment: .leading, spacing: 18) {
                        detailField(label: "NAME") {
                            Text(matchName)
                                .rockwellFont(20).bold()
                                .foregroundStyle(.primary)
                        }
                        
                        detailField(label: "NATIONALITY") {
                            Text(matchNationality)
                                .rockwellFont(16)
                                .foregroundStyle(.primary)
                        }
                        
                        HStack(alignment: .top, spacing: 16) {
                            detailField(label: "COURSE") {
                                Text(matchCourse)
                                    .rockwellFont(16)
                                    .foregroundStyle(.primary)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            detailField(label: "YEAR OF STUDY") {
                                Text(matchYear)
                                    .rockwellFont(16)
                                    .foregroundStyle(.primary)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        
                        detailField(label: "EMAIL") {
                            Button {
                                openEmailComposer()
                            } label: {
                                Text(matchEmail)
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
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 12)
            }
            
            Button {
                tapped.toggle()
                openEmailComposer()
            } label: {
                HStack {
                    Text("Say hello by email")
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
            SCEmailView(recipient: matchEmail, recipientFirstName: "Carlos")
        }
        .alert("Mail Unavailable", isPresented: $showingMailUnavailableAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Mail is not configured on this device. You can email \(matchName) at \(matchEmail).")
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

struct SCEmailView: UIViewControllerRepresentable {
    @Environment(\.dismiss) private var dismiss
    
    var recipient: String = "carlos.mendoza@bristol.ac.uk"
    var recipientFirstName: String = "Carlos"
    
    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = context.coordinator
        
        composer.setToRecipients([recipient])
        composer.setSubject("Arrange a meetup")
        composer.setMessageBody("Hi \(recipientFirstName),", isHTML: false)
        
        return composer
    }
    
    func updateUIViewController(
        _ uiViewController: MFMailComposeViewController,
        context: Context
    ) { }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(dismiss: dismiss)
    }
    
    final class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        private let dismiss: DismissAction
        
        init(dismiss: DismissAction) {
            self.dismiss = dismiss
        }
        
        func mailComposeController(
            _ controller: MFMailComposeViewController,
            didFinishWith result: MFMailComposeResult,
            error: Error?
        ) {
            dismiss()
        }
    }
}

#Preview {
    StudentMatchScreen(connectionType: .constant(.studentConnect), progress: .constant(.matchScreen))
        .environment(AppData())
}
