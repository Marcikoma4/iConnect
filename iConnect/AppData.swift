//
//  AppData.swift
//  iConnect
//
//  Created by Marcell Halmai on 19/11/2026.
//

import Foundation
import Observation

@Observable
class AppData {
    
    enum StudentStatus: String, Hashable, Codable, CaseIterable, Identifiable {
        case international, home
        var id: Self { self }
        
        var displayName: String {
            switch self {
            case .international: "International"
            case .home: "Home"
            }
        }
    }
    
    enum CourseYear: String, Hashable, Codable, CaseIterable, Identifiable {
        case year1, year2, year3, year4, postgraduate
        var id: Self { self }
        
        var displayName: String {
            switch self {
            case .year1: "Year 1"
            case .year2: "Year 2"
            case .year3: "Year 3"
            case .year4: "Year 4"
            case .postgraduate: "Postgraduate"
            }
        }
    }
    
    static let majorLanguages: [String] = [
        "Afrikaans",
        "Albanian",
        "Amharic",
        "Arabic",
        "Bengali",
        "Bulgarian",
        "Burmese",
        "Cantonese",
        "Croatian",
        "Czech",
        "Danish",
        "Dutch",
        "English",
        "Estonian",
        "Finnish",
        "French",
        "German",
        "Greek",
        "Gujarati",
        "Hebrew",
        "Hindi",
        "Hungarian",
        "Indonesian",
        "Irish",
        "Italian",
        "Japanese",
        "Kannada",
        "Korean",
        "Latvian",
        "Lithuanian",
        "Malay",
        "Malayalam",
        "Mandarin",
        "Marathi",
        "Nepali",
        "Norwegian",
        "Persian (Farsi)",
        "Polish",
        "Portuguese",
        "Punjabi",
        "Romanian",
        "Russian",
        "Serbian",
        "Sinhala",
        "Slovak",
        "Slovenian",
        "Somali",
        "Spanish",
        "Swahili",
        "Swedish",
        "Tagalog",
        "Tamil",
        "Telugu",
        "Thai",
        "Turkish",
        "Ukrainian",
        "Urdu",
        "Vietnamese",
        "Welsh"
    ]
    
    static let accommodationSections: [(title: String, items: [String])] = [
        (
            "North Village",
            [
                "Badock Hall",
                "Churchill Hall",
                "Durdham Hall",
                "Hiatt Baker Hall",
                "University Hall",
                "Wills Hall"
            ]
        ),
        (
            "West Village",
            [
                "Clifton Hill House",
                "Goldney Hall",
                "Manor Hall",
                "Queen's Road",
                "Richmond Terrace",
                "Winkworth House",
                "Hillside Woodside",
                "Northwell House",
                "Woodland Court"
            ]
        ),
        (
            "East Village",
            [
                "Campus Houses",
                "Colston Street",
                "Culver House",
                "New Bridewell",
                "Orchard Heights",
                "Redland Road",
                "Riverside",
                "St Michael's Hill",
                "St Michael's Park",
                "The Courtrooms",
                "Woodland Road",
                "Unite House",
                "The Hawthorns"
            ]
        ),
        (
            "Other",
            [
                "Accommodation at Thirty-Three",
                "Avon Point",
                "Brunel House",
                "Campbell House",
                "Chantry Court",
                "Marlborough House",
                "Metal Works",
                "Marketgate",
                "Print Hall",
                "The Rackhay & Favell House",
                "Timber Yard",
                "Tower",
                "St Thomas Street",
                "Langford"
            ]
        )
    ]
    
    static let accommodations: [String] = accommodationSections.flatMap(\.items)
    
    enum ConnectionType: String, Hashable, Codable {
        case studentConnect, homeLink, penPal
    }
    
    enum Progress: Hashable {
        case home, profile, connectionSelector, searchScreen, matchScreen, overview
    }
    
    var hasCreatedProfile: Bool = false {
        didSet { save() }
    }
    var hasConnected: Bool = false {
        didSet { save() }
    }
    
    var firstname: String? {
        didSet { save() }
    }
    var surname: String? {
        didSet { save() }
    }
    var course: String? {
        didSet { save() }
    }
    var accommodation: String? {
        didSet { save() }
    }
    var interests: String? {
        didSet { save() }
    }
    var studentStatus: StudentStatus? {
        didSet { save() }
    }
    var courseYear: CourseYear? {
        didSet { save() }
    }
    var language: String = "English" {
        didSet { save() }
    }
    var selectedConnectionType: ConnectionType? {
        didSet { save() }
    }
    var meetupDays: [String] = [] {
        didSet { save() }
    }
    var meetupTime: String? {
        didSet { save() }
    }
    var meetupLocation: String? {
        didSet { save() }
    }
    
    var currentMonth: Int {
        Calendar.current.component(.month, from: Date())
    }
    
    private static let storageKey = "iConnect.persistedAppData"
    private let defaults: UserDefaults
    @ObservationIgnored private var isUpdating = false
    
    private struct PersistedData: Codable {
        var hasCreatedProfile: Bool = false
        var hasConnected: Bool = false
        var firstname: String?
        var surname: String?
        var course: String?
        var accommodation: String?
        var interests: String?
        var studentStatus: StudentStatus?
        var courseYear: CourseYear?
        var language: String?
        var selectedConnectionType: ConnectionType?
        var meetupDays: [String]?
        var meetupTime: String?
        var meetupLocation: String?
    }
    
    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        load()
    }
    
    private func load() {
        guard let data = defaults.data(forKey: Self.storageKey),
              let saved = try? JSONDecoder().decode(PersistedData.self, from: data) else {
            return
        }
        isUpdating = true
        defer { isUpdating = false }
        
        hasCreatedProfile = saved.hasCreatedProfile
        hasConnected = saved.hasConnected
        firstname = saved.firstname
        surname = saved.surname
        course = saved.course
        accommodation = saved.accommodation
        interests = saved.interests
        studentStatus = saved.studentStatus
        courseYear = saved.courseYear
        if let savedLanguage = saved.language {
            language = Self.majorLanguages.first {
                $0.caseInsensitiveCompare(savedLanguage) == .orderedSame
            } ?? savedLanguage
        } else {
            language = "English"
        }
        selectedConnectionType = saved.selectedConnectionType
        meetupDays = saved.meetupDays ?? []
        meetupTime = saved.meetupTime
        meetupLocation = saved.meetupLocation
    }
    
    private func save() {
        guard !isUpdating else { return }
        let snapshot = PersistedData(
            hasCreatedProfile: hasCreatedProfile,
            hasConnected: hasConnected,
            firstname: firstname,
            surname: surname,
            course: course,
            accommodation: accommodation,
            interests: interests,
            studentStatus: studentStatus,
            courseYear: courseYear,
            language: language,
            selectedConnectionType: selectedConnectionType,
            meetupDays: meetupDays,
            meetupTime: meetupTime,
            meetupLocation: meetupLocation
        )
        if let data = try? JSONEncoder().encode(snapshot) {
            defaults.set(data, forKey: Self.storageKey)
        }
    }
    
    func resetProfile() {
        isUpdating = true
        hasCreatedProfile = false
        hasConnected = false
        firstname = nil
        surname = nil
        course = nil
        accommodation = nil
        interests = nil
        studentStatus = nil
        courseYear = nil
        language = "English"
        selectedConnectionType = nil
        meetupDays = []
        meetupTime = nil
        meetupLocation = nil
        isUpdating = false
        defaults.removeObject(forKey: Self.storageKey)
    }
    
}
