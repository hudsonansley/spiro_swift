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
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let r = Double(min(geometry.size.width, geometry.size.height) / 2)
                let rScaled = r * Double(self.scale)
                let points = Polygon.pointArray(sides: self.sideCount, x: r, y: r, radius: rScaled, offset: 90)
                path.move(
                    to: points[0]
                )
                points.forEach {
                    path.addLine(
                        to: $0
                    )
                }
            }
            .fill(self.color)
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
