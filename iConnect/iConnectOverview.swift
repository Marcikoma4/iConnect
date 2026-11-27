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
    @Binding var connectionType: AppData.ConnectionType
    
    @State private var tapped = false
    @State private var savedTapped = false
    @State private var selectedDays: Set<String> = []
    @State private var meetupTime: String = ""
    @State private var meetupLocation: String = ""
    @State private var showingTimePicker = false
    @State private var pickerDate: Date = Self.defaultPickerDate()
    @State private var showSavedConfirmation = false
    
    private let brandRed = Color(red: 0.65, green: 0.09, blue: 0.19)
    private let borderColor = Color(white: 0.85)
    private let labelColor = Color(white: 0.42)
    private let placeholderColor = Color(white: 0.45)
    
    private let weekdays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    
    private var connectionTitle: String {
        switch connectionType {
        case .studentConnect: "Student connect"
        case .homeLink: "Home link"
        case .penPal: "Pen & pal"
        }
    }
    
    private var connectionSubtitle: String {
        switch connectionType {
        case .studentConnect: "Matched with John Doe"
        case .homeLink: "Hosted by Dr Jane Doe · 2 students"
        case .penPal: "Matched with John Doe"
        }
    }
    
    private var connectionSymbol: String {
        switch connectionType {
        case .studentConnect: "person.2"
        case .homeLink: "house"
        case .penPal: "envelope"
        }
    }
    
    private var orderedSelectedDays: [String] {
        weekdays.filter { selectedDays.contains($0) }
    }
    
    private var hasUnsavedChanges: Bool {
        let savedDays = Set(appData.meetupDays)
        let savedTime = appData.meetupTime ?? ""
        let savedLocation = appData.meetupLocation ?? ""
        let currentLocation = meetupLocation.trimmingCharacters(in: .whitespacesAndNewlines)
        
        return selectedDays != savedDays ||
               meetupTime != savedTime ||
               currentLocation != savedLocation
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                MonthHeader()
                Button {
                    tapped.toggle()
                    progress = nil
                } label: {
                    Text("Home")
                }
                .padding(.trailing, 25)
                .buttonStyle(.glass)
                .controlSize(.large)
                .sensoryFeedback(.success, trigger: tapped)
            }
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Your iConnect")
                            .rockwellFont(12).bold()
                            .foregroundStyle(brandRed)
                        
                        Text("Connection overview")
                            .rockwellFont(26).bold()
                    }
                    .padding(.top, 14)
                    
                    // Active connection summary card
                    Button {
                        tapped.toggle()
                        progress = .matchScreen
                    } label: {
                        ZStack {
                            VStack(alignment: .leading, spacing: 6) {
                                Text("ACTIVE CONNECTION")
                                    .rockwellFont(11).bold()
                                    .tracking(0.8)
                                    .foregroundStyle(.white.opacity(0.85))
                                
                                Text(connectionTitle)
                                    .rockwellFont(22).bold()
                                    .foregroundStyle(.white)
                                
                                Text(connectionSubtitle)
                                    .rockwellFont(14)
                                    .foregroundStyle(.white.opacity(0.92))
                                    .multilineTextAlignment(.leading)
                                
                                Spacer(minLength: 4)
                                
                                HStack(spacing: 4) {
                                    Text("View match details")
                                        .rockwellFont(13).bold()
                                    Image(systemName: "chevron.right")
                                        .font(.system(size: 11, weight: .bold))
                                }
                                .foregroundStyle(.white.opacity(0.95))
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                            .padding(.top, 18)
                            .padding(.bottom, 16)
                            .padding(.leading, 18)
                            .padding(.trailing, 112)
                            
                            VStack {
                                Spacer()
                                HStack {
                                    Spacer()
                                    Circle()
                                        .fill(.white)
                                        .frame(width: 82, height: 82)
                                        .overlay {
                                            Image(systemName: connectionSymbol)
                                                .font(.system(size: 30, weight: .regular))
                                                .foregroundStyle(brandRed)
                                                .offset(y: -3)
                                        }
                                        .offset(y: 14)
                                        .padding(.trailing, 16)
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding(.bottom, -55)
                    }
                    .buttonStyle(.custom(variant: .regular))
                    .frame(height: 150)
                    .sensoryFeedback(.success, trigger: tapped)
                    
                    if connectionType != .penPal {
                        meetupSection
                    } else {
                        penPalSection
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                .padding(.bottom, 12)
            }
            .scrollDismissesKeyboard(.interactively)
            
            if connectionType != .penPal {
                Button {
                    saveMeetupDetails()
                    savedTapped.toggle()
                } label: {
                    HStack {
                        Text("Save meetup details")
                            .rockwellFont(22)
                        Spacer()
                        Image(systemName: "checkmark")
                            .font(.system(size: 20, weight: .semibold))
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.horizontal, 20)
                }
                .buttonStyle(.custom(variant: .regular))
                .saturation(hasUnsavedChanges ? 1.0 : 0.0)
                .opacity(hasUnsavedChanges ? 1.0 : 0.45)
                .disabled(!hasUnsavedChanges)
                .animation(.easeInOut(duration: 0.2), value: hasUnsavedChanges)
                .frame(height: 115)
                .padding(.horizontal, 20)
                .padding(.top, 8)
                .padding(.bottom, 6)
                .sensoryFeedback(.success, trigger: savedTapped)
            } else {
                Button {
                    tapped.toggle()
                    progress = .matchScreen
                } label: {
                    HStack {
                        Text("View match details")
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
            }
            
            CustomTabBar()
        }
        .onAppear {
            appData.hasConnected = true
            loadMeetupDetails()
        }
        .sheet(isPresented: $showingTimePicker) {
            MeetupTimePickerSheet(
                pickerDate: $pickerDate,
                meetupTime: $meetupTime,
                brandRed: brandRed
            )
            .presentationDetents([.height(310)])
            .presentationDragIndicator(.visible)
        }
    }
    
    // MARK: - Regular Meetup Section (Student Connect & HomeLink)
    
    private var meetupSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
                Text("Regular meetup")
                    .rockwellFont(20).bold()
                
                Text("Keep track of the meetups you’ve arranged with your \(connectionType == .homeLink ? "HomeLink family" : "matched student").")
                    .rockwellFont(13)
                    .foregroundStyle(labelColor)
            }
            .padding(.top, 4)
            
            VStack(alignment: .leading, spacing: 16) {
                // Day(s) selector
                VStack(alignment: .leading, spacing: 8) {
                    Text("DAY(S)")
                        .rockwellFont(11).bold()
                        .tracking(0.8)
                        .foregroundStyle(labelColor)
                    
                    HStack(spacing: 6) {
                        ForEach(weekdays, id: \.self) { day in
                            let isSelected = selectedDays.contains(day)
                            Button {
                                withAnimation(.easeInOut(duration: 0.15)) {
                                    if isSelected {
                                        selectedDays.remove(day)
                                    } else {
                                        selectedDays.insert(day)
                                    }
                                    showSavedConfirmation = false
                                }
                            } label: {
                                Text(day)
                                    .rockwellFont(12)
                                    .fontWeight(isSelected ? .bold : .regular)
                                    .foregroundStyle(isSelected ? .white : Color(white: 0.35))
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 38)
                                    .background(
                                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                                            .fill(isSelected ? brandRed : Color(.systemBackground))
                                    )
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                                            .stroke(isSelected ? brandRed : borderColor, lineWidth: 1)
                                    )
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                
                // Time (xx:xx)
                VStack(alignment: .leading, spacing: 6) {
                    Text("TIME")
                        .rockwellFont(11).bold()
                        .tracking(0.8)
                        .foregroundStyle(labelColor)
                    
                    Button {
                        syncPickerDateFromTime()
                        showingTimePicker = true
                    } label: {
                        HStack {
                            Text(meetupTime.isEmpty ? "xx:xx" : meetupTime)
                                .rockwellFont(14)
                                .foregroundStyle(meetupTime.isEmpty ? placeholderColor : .primary)
                            Spacer()
                            Image(systemName: "clock")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundStyle(Color(white: 0.35))
                        }
                        .padding(.horizontal, 12)
                        .frame(height: 44)
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(Color(.systemBackground))
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .stroke(borderColor, lineWidth: 1)
                        )
                    }
                    .buttonStyle(.plain)
                }
                
                // Location
                VStack(alignment: .leading, spacing: 6) {
                    Text("LOCATION")
                        .rockwellFont(11).bold()
                        .tracking(0.8)
                        .foregroundStyle(labelColor)
                    
                    TextField("e.g. Senate House Café", text: $meetupLocation)
                        .rockwellFont(14)
                        .textInputAutocapitalization(.words)
                        .onChange(of: meetupLocation) {
                            showSavedConfirmation = false
                        }
                        .padding(.horizontal, 12)
                        .frame(height: 44)
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(Color(.systemBackground))
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .stroke(borderColor, lineWidth: 1)
                        )
                }
                
                if showSavedConfirmation {
                    HStack(spacing: 6) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 14))
                        Text("Meetup details saved")
                            .rockwellFont(13).bold()
                    }
                    .foregroundStyle(brandRed)
                    .transition(.opacity)
                }
            }
            .padding(18)
            .background(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .fill(brandRed.opacity(0.05))
            )
            .onChange(of: meetupTime) {
                showSavedConfirmation = false
            }
        }
    }
    
    // MARK: - Pen & Pal Info Section
    
    private var penPalSection: some View {
        HStack(alignment: .top, spacing: 14) {
            Circle()
                .fill(brandRed.opacity(0.10))
                .frame(width: 42, height: 42)
                .overlay {
                    Image(systemName: "envelope")
                        .font(.system(size: 17, weight: .medium))
                        .foregroundStyle(brandRed)
                }
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Pen & pal correspondence")
                    .rockwellFont(16).bold()
                    .foregroundStyle(.primary)
                
                Text("No in-person meetups needed — stay in touch with John Doe at your own pace and practise \(appData.language).")
                    .rockwellFont(14)
                    .foregroundStyle(labelColor)
                    .fixedSize(horizontal: false, vertical: true)
                    .lineSpacing(2)
            }
            
            Spacer(minLength: 0)
        }
        .padding(18)
        .background(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .fill(brandRed.opacity(0.05))
        )
    }
    
    // MARK: - Persistence Helpers
    
    private func loadMeetupDetails() {
        selectedDays = Set(appData.meetupDays)
        meetupTime = appData.meetupTime ?? ""
        meetupLocation = appData.meetupLocation ?? ""
        syncPickerDateFromTime()
    }
    
    private func saveMeetupDetails() {
        let trimmedLocation = meetupLocation.trimmingCharacters(in: .whitespacesAndNewlines)
        meetupLocation = trimmedLocation
        appData.meetupDays = orderedSelectedDays
        appData.meetupTime = meetupTime.isEmpty ? nil : meetupTime
        appData.meetupLocation = trimmedLocation.isEmpty ? nil : trimmedLocation
        
        withAnimation(.easeInOut(duration: 0.2)) {
            showSavedConfirmation = true
        }
    }
    
    private func syncPickerDateFromTime() {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.locale = Locale(identifier: "en_GB")
        if let parsed = formatter.date(from: meetupTime) {
            pickerDate = parsed
        } else {
            pickerDate = Self.defaultPickerDate()
        }
    }
    
    private static func defaultPickerDate() -> Date {
        Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: Date()) ?? Date()
    }
}

private struct MeetupTimePickerSheet: View {
    @Binding var pickerDate: Date
    @Binding var meetupTime: String
    let brandRed: Color
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button {
                    meetupTime = ""
                    dismiss()
                } label: {
                    Text("Clear")
                        .rockwellFont(15)
                        .foregroundStyle(Color(white: 0.42))
                }
                
                Spacer()
                
                Text("Select time")
                    .rockwellFont(18).bold()
                
                Spacer()
                
                Button {
                    meetupTime = Self.formatTime(pickerDate)
                    dismiss()
                } label: {
                    Text("Done")
                        .rockwellFont(15).bold()
                        .foregroundStyle(brandRed)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            .padding(.bottom, 8)
            
            DatePicker(
                "Meetup time",
                selection: $pickerDate,
                displayedComponents: .hourAndMinute
            )
            .datePickerStyle(.wheel)
            .labelsHidden()
            .environment(\.locale, Locale(identifier: "en_GB"))
            .padding(.horizontal, 20)
            
            Spacer(minLength: 0)
        }
    }
    
    private static func formatTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.locale = Locale(identifier: "en_GB")
        return formatter.string(from: date)
    }
}

#Preview("Student Connect") {
    iConnectOverview(
        progress: .constant(.overview),
        connectionType: .constant(.studentConnect)
    )
    .environment(AppData())
}

#Preview("HomeLink") {
    iConnectOverview(
        progress: .constant(.overview),
        connectionType: .constant(.homeLink)
    )
    .environment(AppData())
}

#Preview("Pen & Pal") {
    iConnectOverview(
        progress: .constant(.overview),
        connectionType: .constant(.penPal)
    )
    .environment(AppData())
}
