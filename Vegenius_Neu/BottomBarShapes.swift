//
//  BottomBarShapes.swift
//  Vegenius_Neu
//
//  Created by TA620 on 15.03.26.
//

import SwiftUI

struct HalfCircle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(
            center: CGPoint(x: rect.midX, y: rect.maxY),
            radius: rect.width / 2,
            startAngle: .degrees(180),
            endAngle: .degrees(0),
            clockwise: false
        )
        return path
    }
}

struct CurvedBottomBarShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        let curveHeight: CGFloat = 35
        let curveWidth: CGFloat = 90
        let centerX = rect.midX

        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: centerX - curveWidth, y: 0))

        path.addQuadCurve(
            to: CGPoint(x: centerX, y: -curveHeight),
            control: CGPoint(x: centerX - curveWidth / 2, y: 0)
        )

        path.addQuadCurve(
            to: CGPoint(x: centerX + curveWidth, y: 0),
            control: CGPoint(x: centerX + curveWidth / 2, y: 0)
        )

        path.addLine(to: CGPoint(x: rect.width, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        path.closeSubpath()

        return path
    }
}

struct HalfEllipse: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.addEllipse(
            in: CGRect(
                x: 0,
                y: rect.height / 2,
                width: rect.width,
                height: rect.height
            )
        )

        return path
    }
}
