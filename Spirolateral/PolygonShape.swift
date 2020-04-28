//
//  PolygonView.swift
//  spirolateral
//
//  Created by Hudson Ansley on 7/6/19.
//  Copyright © 2019 hlamedia. All rights reserved.
//

import SwiftUI

struct PolygonShape: Shape {
    var sideCount:Int
    var scale:CGFloat = 1.0
    var offsetDegrees:CGFloat = 90
    func path(in rect: CGRect) -> Path {
        var p = Path()
        let r = Polygon.radius(size:rect.size)
        let rScaled = r * self.scale
        let points = Polygon.vertices(sides: self.sideCount, cx: r, cy: r, radius: rScaled, offsetDegrees: self.offsetDegrees)
        p.move(
            to: points[0]
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
}

#if DEBUG
//struct PolygonView_Previews : PreviewProvider {
//    static var previews: some View {
//        PolygonView(sideCount:self.sideCount)
//    }
//}
#endif
