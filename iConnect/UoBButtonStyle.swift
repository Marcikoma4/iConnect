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
//                .background {
//                    backgroundShape
//                        .fill(
//                            buttonRed,
//                            style: FillStyle(eoFill: variant == .cutout)
//                        )
//                }
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

        let cornerRadius: CGFloat = 20
        let notchRadius = rect.width * 0.15
        let notchCenterY = rect.height * 0.72

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

        // Continue down the right edge.
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - cornerRadius))

        // Bottom-right corner.
        path.addArc(
            center: CGPoint(x: rect.maxX - cornerRadius,
                           y: rect.maxY - cornerRadius),
            radius: cornerRadius,
            startAngle: .degrees(0),
            endAngle: .degrees(90),
            clockwise: false
        )

        // Bottom edge.
        path.addLine(to: CGPoint(x: rect.minX + cornerRadius, y: rect.maxY))

        // Bottom-left corner.
        path.addArc(
            center: CGPoint(x: rect.minX + cornerRadius,
                           y: rect.maxY - cornerRadius),
            radius: cornerRadius,
            startAngle: .degrees(90),
            endAngle: .degrees(180),
            clockwise: false
        )

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
