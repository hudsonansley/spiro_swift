//
//  PolygonView.swift
//  spirolateral
//
//  Created by Hudson Ansley on 7/6/19.
//  Copyright © 2019 hlamedia. All rights reserved.
//

import SwiftUI

struct PolygonView : View {
    var sideCount:Int
    var scale:CGFloat = 1.0
    var color:Color = Color.white
    var lineWidth:CGFloat = 16.0
    var offsetDegrees:CGFloat = 90
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let r = Polygon.radius(size:geometry.size)
                let rScaled = r * self.scale - self.lineWidth / 2
                let points = Polygon.vertices(sides: self.sideCount, cx: r, cy: r, radius: rScaled, offsetDegrees: self.offsetDegrees)
                path.move(
                    to: points[0]
                )
                points.forEach {
                    path.addLine(
                        to: $0
                    )
                }
                path.closeSubpath()
            }
            .stroke(self.color, lineWidth: self.lineWidth)
//            .fill(self.color)
        }
    }
}

#if DEBUG
//struct PolygonView_Previews : PreviewProvider {
//    static var previews: some View {
//        PolygonView(sideCount:self.sideCount)
//    }
//}
#endif
