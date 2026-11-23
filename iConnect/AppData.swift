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
    
    var hasCreatedProfile = false
    var hasConnected = false 
    
    enum ConnectionType: Hashable {
        case studentConnect, homeLink, penPal
    }
    
    enum Progress: Hashable {
        case home, profile, connectionSelector, searchScreen, matchScreen, overview
    }
    
    var currentMonth: Int {
        Calendar.current.component(.month, from: Date())
    }
    
}
