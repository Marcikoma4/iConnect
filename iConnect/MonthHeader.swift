//
//  MonthHeader.swift
//  iConnect
//
//  Created by Marcell Halmai on 22/11/2026.
//

import SwiftUI

struct MonthHeader: View {
    @Environment(AppData.self) private var appData

    private var imageName: String {
        switch appData.currentMonth {
        case 1: "JanuaryImage"
        case 2: "FebruaryImage"
        case 3: "MarchImage"
        case 4: "AprilImage"
        case 5: "MayImage"
        case 6: "JuneImage"
        case 7: "JulyImage"
        case 8: "AugustImage"
        case 9: "SeptemberImage"
        case 10: "OctoberImage"
        case 11: "NovemberImage"
        case 12: "DecemberImage"
        default: "JanuaryImage"
        }
    }

    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFit()
            .frame(height: 65)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 30)
            .padding(.top, 10)
    }
}
