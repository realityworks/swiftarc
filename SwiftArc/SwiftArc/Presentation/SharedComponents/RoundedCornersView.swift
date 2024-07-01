//
//  RoundedCornersView.swift
//

import SwiftUI

struct RoundedCornersView<S: ShapeStyle>: View {
    var topLeft: Double = 0
    var topRight: Double = 0

    var bottomLeft: Double = 0
    var bottomRight: Double = 0

    var fill: S

    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let width = geometry.size.width
                let height = geometry.size.height

                // Top left corner
                path.move(to: CGPoint(x: 0, y: topLeft))
                path.addArc(center: CGPoint(x: topLeft, y: topLeft), radius: topLeft, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)

                // Top edge
                path.addLine(to: CGPoint(x: width - topRight, y: 0))
                path.addArc(center: CGPoint(x: width - topRight, y: topRight), radius: topRight, startAngle: Angle(degrees: 270), endAngle: Angle(degrees: 0), clockwise: false)

                // Right edge
                path.addLine(to: CGPoint(x: width, y: height - bottomRight))
                path.addArc(center: CGPoint(x: width - bottomRight, y: height - bottomRight), radius: bottomRight, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)

                // Bottom edge
                path.addLine(to: CGPoint(x: bottomLeft, y: height))
                path.addArc(center: CGPoint(x: bottomLeft, y: height - bottomLeft), radius: bottomLeft, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)

                // Left edge
                path.addLine(to: CGPoint(x: 0, y: bottomLeft))
            }
            .fill(
                fill
            )
        }
    }
}

struct RoundedCornersView_Previews: PreviewProvider {
    static var previews: some View {
        RoundedCornersView(
            topLeft: 30,
            topRight: 30,
            fill: Color.red
        )
        .padding(10)
    }
}
