//
//  UoBButtonStyle.swift
//  iConnect
//
//  Created by Marcell Halmai on 19/11/2026.
//

import SwiftUI

enum Custom {

    enum ButtonVariant {
        case cutout
        case regular
    }

    struct ButtonStyle: SwiftUI.ButtonStyle {

        let variant: ButtonVariant

        // University of Bristol-style red.
        private let buttonRed = Color(red: 0.65, green: 0.09, blue: 0.19)

        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .foregroundStyle(.white)
                .padding(.bottom, variant == .cutout ? 65 : 55)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background {
                    backgroundShape.fill(buttonRed)
                }
                .overlay {
                    // A subtle visual response when the button is pressed.
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.white.opacity(configuration.isPressed ? 0.08 : 0))
                }
                .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
                .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
                .clipShape(backgroundShape)
        }

        private var backgroundShape: AnyShape {
            switch variant {
            case .cutout:
                AnyShape(CutoutButtonShape())
            case .regular:
                AnyShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            }
        }
    }
}

// Cutout Shape

struct CutoutButtonShape: Shape {

    func path(in rect: CGRect) -> Path {
        var path = Path()

        let cornerRadius: CGFloat = 10 // when this is removed the problem goes away, however we need a corner radius for the top left and top right
        let notchRadius = rect.width * 0.18
        let notchCenterY = rect.height * 0.81

        let leftNotchTop = notchCenterY - notchRadius
        let leftNotchBottom = notchCenterY + notchRadius

        let rightNotchTop = notchCenterY - notchRadius
        let rightNotchBottom = notchCenterY + notchRadius

        // Start at the top-left corner, after the corner radius.
        path.move(to: CGPoint(x: cornerRadius, y: rect.minY))

        // Top edge.
        path.addLine(to: CGPoint(x: rect.maxX - cornerRadius, y: rect.minY))

        // Top-right corner.
        path.addArc(
            center: CGPoint(x: rect.maxX - cornerRadius,
                           y: rect.minY + cornerRadius),
            radius: cornerRadius,
            startAngle: .degrees(-90),
            endAngle: .degrees(0),
            clockwise: false
        )

        // Right edge, down to the notch.
        path.addLine(to: CGPoint(x: rect.maxX, y: rightNotchTop))

        // Right-side inward notch.
        path.addArc(
            center: CGPoint(x: rect.maxX, y: notchCenterY),
            radius: notchRadius,
            startAngle: .degrees(-90),
            endAngle: .degrees(90),
            clockwise: true
        )
        
        // Continue down the right edge to the bottom.
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))

        // Straight bottom edge (no rounded bottom corners).
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))

        // Left edge, up to the notch.
        path.addLine(to: CGPoint(x: rect.minX, y: leftNotchBottom))

        // Left-side inward notch.
        path.addArc(
            center: CGPoint(x: rect.minX, y: notchCenterY),
            radius: notchRadius,
            startAngle: .degrees(90),
            endAngle: .degrees(-90),
            clockwise: true
        )

        // Continue up the left edge.
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + cornerRadius))

        // Top-left corner.
        path.addArc(
            center: CGPoint(x: rect.minX + cornerRadius,
                           y: rect.minY + cornerRadius),
            radius: cornerRadius,
            startAngle: .degrees(180),
            endAngle: .degrees(270),
            clockwise: false
        )

        path.closeSubpath()

        return path
    }
}

// Style Convenience

extension SwiftUI.ButtonStyle where Self == Custom.ButtonStyle {

    static func custom(variant: Custom.ButtonVariant) -> Self {
        .init(variant: variant)
    }
}
