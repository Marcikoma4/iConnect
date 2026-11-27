//
//  Profile.swift
//  iConnect
//
//  Created by Marcell Halmai on 19/11/2026.
//

import SwiftUI

struct Profile: View {
    
    @State private var tapped = false
    @State private var errorTapped = false
    @State private var showValidationErrors = false
    @Environment(AppData.self) private var appData
    @Binding var progress: AppData.Progress?
    
    @State private var firstname: String = ""
    @State private var surname: String = ""
    @State private var course: String = ""
    @State private var selectedYear: AppData.CourseYear?
    @State private var selectedLanguage: String = "English"
    @State private var showingLanguagePicker = false
    @State private var accommodation: String = ""
    @State private var interests: String = ""
    @State private var selectedStatus: AppData.StudentStatus = .international
    
    private let brandRed = Color(red: 0.65, green: 0.09, blue: 0.19)
    private let borderColor = Color(white: 0.85)
    private let labelColor = Color(white: 0.28)
    private let placeholderColor = Color(white: 0.45)
    
    private let accommodationOptions = [
        "North Village",
        "East Village",
        "West Village",
        "Other undergraduate accomodation",
        "Private Halls",
        "Private Housing",
        "Living at Home (in Bristol)",
        "Commuting from different region",
    ]
    
    private var isFirstnameMissing: Bool { nonEmpty(firstname) == nil }
    private var isSurnameMissing: Bool { nonEmpty(surname) == nil }
    private var isCourseMissing: Bool { nonEmpty(course) == nil }
    private var isYearMissing: Bool { selectedYear == nil }
    private var isLanguageMissing: Bool { nonEmpty(selectedLanguage) == nil }
    private var isAccommodationMissing: Bool { nonEmpty(accommodation) == nil }
    
    private var isFormValid: Bool {
        !isFirstnameMissing &&
        !isSurnameMissing &&
        !isCourseMissing &&
        !isYearMissing &&
        !isLanguageMissing &&
        !isAccommodationMissing
    }
    
    var body: some View {
        VStack(spacing: 0) {
            MonthHeader()
            
            Text("Your first step")
                .rockwellFont(12)
                .foregroundStyle(brandRed)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 20)
                .padding(.top, 16)
            
            VStack(alignment: .leading, spacing: 6) {
                Text("Create your profile")
                    .rockwellFont(24).bold()
                
                Text("A little about you helps us find your people.")
                    .rockwellFont(14)
                    .foregroundStyle(placeholderColor)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)
            .padding(.top, 12)
            .padding(.bottom, 12)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    
                    // First name & Surname
                    HStack(spacing: 12) {
                        fieldContainer(title: "First name", isRequired: true) {
                            TextField("Your first name", text: $firstname)
                                .rockwellFont(14)
                                .textContentType(.givenName)
                                .textInputAutocapitalization(.words)
                                .modifier(InputFieldModifier(
                                    borderColor: fieldBorderColor(isInvalid: showValidationErrors && isFirstnameMissing),
                                    lineWidth: showValidationErrors && isFirstnameMissing ? 1.5 : 1
                                ))
                        }
                        
                        fieldContainer(title: "Surname", isRequired: true) {
                            TextField("Your surname", text: $surname)
                                .rockwellFont(14)
                                .textContentType(.familyName)
                                .textInputAutocapitalization(.words)
                                .modifier(InputFieldModifier(
                                    borderColor: fieldBorderColor(isInvalid: showValidationErrors && isSurnameMissing),
                                    lineWidth: showValidationErrors && isSurnameMissing ? 1.5 : 1
                                ))
                        }
                    }
                    
                    // Course & Year
                    HStack(spacing: 12) {
                        fieldContainer(title: "Course", isRequired: true) {
                            TextField("Your course", text: $course)
                                .rockwellFont(14)
                                .textInputAutocapitalization(.words)
                                .modifier(InputFieldModifier(
                                    borderColor: fieldBorderColor(isInvalid: showValidationErrors && isCourseMissing),
                                    lineWidth: showValidationErrors && isCourseMissing ? 1.5 : 1
                                ))
                        }
                        
                        fieldContainer(title: "Year", isRequired: true) {
                            Menu {
                                ForEach(AppData.CourseYear.allCases) { year in
                                    Button {
                                        selectedYear = year
                                    } label: {
                                        Text(year.displayName)
                                            .rockwellFont(14)
                                    }
                                }
                            } label: {
                                dropdownLabel(
                                    text: selectedYear?.displayName ?? "Select",
                                    isPlaceholder: selectedYear == nil,
                                    isInvalid: showValidationErrors && isYearMissing
                                )
                            }
                        }
                        .frame(width: 120)
                    }
                    
                    // Language & Accommodation
                    HStack(spacing: 12) {
                        fieldContainer(title: "Language", isRequired: true) {
                            Button {
                                showingLanguagePicker = true
                            } label: {
                                dropdownLabel(
                                    text: selectedLanguage,
                                    isPlaceholder: false,
                                    isInvalid: showValidationErrors && isLanguageMissing
                                )
                            }
                            .buttonStyle(.plain)
                        }
                        
                        fieldContainer(title: "Accommodation", isRequired: true) {
                            Menu {
                                ForEach(accommodationOptions, id: \.self) { option in
                                    Button {
                                        accommodation = option
                                    } label: {
                                        Text(option)
                                            .rockwellFont(14)
                                    }
                                }
                            } label: {
                                dropdownLabel(
                                    text: accommodation.isEmpty ? "Select" : accommodation,
                                    isPlaceholder: accommodation.isEmpty,
                                    isInvalid: showValidationErrors && isAccommodationMissing
                                )
                            }
                        }
                    }
                    
                    // Interests (optional)
                    fieldContainer(title: "Interests", isRequired: false) {
                        TextField("Add your interests", text: $interests)
                            .rockwellFont(14)
                            .modifier(InputFieldModifier(borderColor: borderColor, lineWidth: 1))
                    }
                    
                    // Student status
                    fieldContainer(title: "Student status", isRequired: true) {
                        HStack(spacing: 0) {
                            ForEach(AppData.StudentStatus.allCases) { status in
                                let isSelected = selectedStatus == status
                                Button {
                                    withAnimation(.easeInOut(duration: 0.18)) {
                                        selectedStatus = status
                                    }
                                } label: {
                                    Text(status.displayName)
                                        .rockwellFont(15)
                                        .fontWeight(isSelected ? .bold : .regular)
                                        .foregroundStyle(isSelected ? .white : Color(white: 0.35))
                                        .frame(maxWidth: .infinity)
                                        .padding(.vertical, 12)
                                        .background {
                                            if isSelected {
                                                RoundedRectangle(cornerRadius: 8, style: .continuous)
                                                    .fill(brandRed)
                                            }
                                        }
                                        .contentShape(Rectangle())
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(4)
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(brandRed.opacity(0.06))
                        )
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 4)
                .padding(.bottom, 12)
            }
            .scrollDismissesKeyboard(.interactively)
            
            if showValidationErrors && !isFormValid {
                HStack(spacing: 6) {
                    Image(systemName: "exclamationmark.circle.fill")
                        .font(.system(size: 13))
                    Text("Please fill in all required fields (*)")
                        .rockwellFont(13)
                }
                .foregroundStyle(brandRed)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                .padding(.top, 6)
            }
            
            Button {
                if isFormValid {
                    showValidationErrors = false
                    saveProfile()
                    tapped.toggle()
                    progress = .connectionSelector
                } else {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        showValidationErrors = true
                    }
                    errorTapped.toggle()
                }
            } label: {
                HStack {
                    Text("Save & continue")
                        .rockwellFont(22)
                    Spacer()
                    Image(systemName: "arrow.right")
                        .font(.system(size: 20, weight: .semibold))
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.horizontal, 20)
            }
            .buttonStyle(.custom(variant: .regular))
            .opacity(isFormValid ? 1.0 : 0.65)
            .frame(height: 115)
            .padding(.horizontal, 20)
            .padding(.top, 8)
            .padding(.bottom, 6)
            .sensoryFeedback(.success, trigger: tapped)
            .sensoryFeedback(.error, trigger: errorTapped)
            
            CustomTabBar()
        }
        .onAppear {
            loadExistingProfile()
        }
        .sheet(isPresented: $showingLanguagePicker) {
            LanguagePickerSheet(
                selectedLanguage: $selectedLanguage,
                languages: AppData.majorLanguages,
                brandRed: brandRed,
                borderColor: borderColor
            )
            .presentationDetents([.medium, .large])
            .presentationDragIndicator(.visible)
        }
    }
    
    private func fieldBorderColor(isInvalid: Bool) -> Color {
        isInvalid ? brandRed : borderColor
    }
    
    @ViewBuilder
    private func fieldContainer<Content: View>(
        title: String,
        isRequired: Bool = true,
        @ViewBuilder content: () -> Content
    ) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 2) {
                Text(title)
                    .rockwellFont(13)
                    .bold()
                    .foregroundStyle(labelColor)
                if isRequired {
                    Text("*")
                        .rockwellFont(13)
                        .bold()
                        .foregroundStyle(brandRed)
                }
            }
            
            content()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private func dropdownLabel(text: String, isPlaceholder: Bool, isInvalid: Bool = false) -> some View {
        HStack(spacing: 6) {
            Text(text)
                .rockwellFont(14)
                .foregroundStyle(isPlaceholder ? placeholderColor : .primary)
                .lineLimit(1)
            Spacer(minLength: 4)
            Image(systemName: "chevron.down")
                .font(.system(size: 13, weight: .semibold))
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
                .stroke(fieldBorderColor(isInvalid: isInvalid), lineWidth: isInvalid ? 1.5 : 1)
        )
    }
    
    private func loadExistingProfile() {
        firstname = appData.firstname ?? ""
        surname = appData.surname ?? ""
        course = appData.course ?? ""
        selectedYear = appData.courseYear
        selectedLanguage = appData.language
        accommodation = appData.accommodation ?? ""
        interests = appData.interests ?? ""
        selectedStatus = appData.studentStatus ?? .international
    }
    
    private func saveProfile() {
        appData.firstname = nonEmpty(firstname)
        appData.surname = nonEmpty(surname)
        appData.course = nonEmpty(course)
        appData.courseYear = selectedYear
        appData.language = selectedLanguage
        appData.accommodation = nonEmpty(accommodation)
        appData.interests = nonEmpty(interests)
        appData.studentStatus = selectedStatus
        appData.hasCreatedProfile = true
    }
    
    private func nonEmpty(_ value: String) -> String? {
        let trimmed = value.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed.isEmpty ? nil : trimmed
    }
}

private struct InputFieldModifier: ViewModifier {
    let borderColor: Color
    var lineWidth: CGFloat = 1
    
    func body(content: Content) -> some View {
        content
            .padding(.horizontal, 12)
            .frame(height: 44)
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(Color(.systemBackground))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .stroke(borderColor, lineWidth: lineWidth)
            )
    }
}

private struct LanguagePickerSheet: View {
    @Binding var selectedLanguage: String
    let languages: [String]
    let brandRed: Color
    let borderColor: Color
    
    @Environment(\.dismiss) private var dismiss
    @State private var searchText: String = ""
    
    private var filteredLanguages: [String] {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !query.isEmpty else { return languages }
        return languages.filter { $0.localizedCaseInsensitiveContains(query) }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Select language")
                    .rockwellFont(20).bold()
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Text("Done")
                        .rockwellFont(15).bold()
                        .foregroundStyle(brandRed)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            .padding(.bottom, 12)
            
            HStack(spacing: 8) {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(Color(white: 0.45))
                TextField("Search languages", text: $searchText)
                    .rockwellFont(14)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                if !searchText.isEmpty {
                    Button {
                        searchText = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 15))
                            .foregroundStyle(Color(white: 0.55))
                    }
                    .buttonStyle(.plain)
                }
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
            .padding(.horizontal, 20)
            .padding(.bottom, 12)
            
            Divider()
            
            if filteredLanguages.isEmpty {
                Text("No languages found")
                    .rockwellFont(14)
                    .foregroundStyle(Color(white: 0.45))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(filteredLanguages, id: \.self) { language in
                            let isSelected = language == selectedLanguage
                            Button {
                                selectedLanguage = language
                                dismiss()
                            } label: {
                                HStack {
                                    Text(language)
                                        .rockwellFont(15)
                                        .fontWeight(isSelected ? .bold : .regular)
                                        .foregroundStyle(isSelected ? brandRed : .primary)
                                    Spacer()
                                    if isSelected {
                                        Image(systemName: "checkmark")
                                            .font(.system(size: 14, weight: .bold))
                                            .foregroundStyle(brandRed)
                                    }
                                }
                                .padding(.horizontal, 20)
                                .padding(.vertical, 14)
                                .contentShape(Rectangle())
                            }
                            .buttonStyle(.plain)
                            
                            Divider()
                                .padding(.leading, 20)
                        }
                    }
                }
                .scrollDismissesKeyboard(.interactively)
            }
        }
    }
}

#Preview {
    Profile(progress: .constant(.profile))
        .environment(AppData())
}
