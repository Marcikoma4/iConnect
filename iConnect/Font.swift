//
//  Font.swift
//  iConnect
//
//  Created by Marcell Halmai on 20/11/2026.
//

import Foundation
import SwiftUI

extension View {
    func rockwellFont(_ size: CGFloat) -> some View {
        self.font(.custom("Rockwell", size: size))
    }
}
