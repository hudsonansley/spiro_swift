//
//  PolygonView.swift
//  spirolateral
//
//  Created by Hudson Ansley on 7/6/19.
//  Copyright © 2019 hlamedia. All rights reserved.
//

import SwiftUI

struct PolygonShape: InsettableShape {
    var insetAmount: CGFloat = 0

    var sideCount:Int
    var scale:CGFloat = 1.0
    var offsetDegrees:CGFloat = 90
    func path(in rect: CGRect) -> Path {
        var p = Path()
        let r = Polygon.radius(size:rect.size)
        let rScaled = r * self.scale - 1.4 * insetAmount
        let points = Polygon.vertices(sides: self.sideCount, cx: r, cy: r, radius: rScaled, offsetDegrees: self.offsetDegrees)
        p.move(
            to: points.last ?? .zero
        )
        points.forEach {
            p.addLine(
                to: $0
            )
        }
        p.closeSubpath()
        return p
    }
//            var animatableData
    func inset(by amount: CGFloat) -> some InsettableShape {
        var poly = self
        poly.insetAmount = amount
        return poly
    }
}

#if DEBUG
struct PolygonShape_Previews : PreviewProvider {
    static var previews: some View {
        PolygonShape(sideCount:4).strokeBorder(Color.green, lineWidth: 30)
    }
}
#endif
