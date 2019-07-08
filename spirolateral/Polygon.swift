//
//  Polygon.swift
//  spirolateral
//
//  Created by Hudson Ansley on 7/5/19.
//  Copyright © 2019 hlamedia. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit

extension CGFloat {
    func radians() -> CGFloat {
        return .pi * self / 180.0
    }
}

class Polygon:NSObject {

    public class func pointArray(sides:Int, cx:CGFloat, cy:CGFloat, radius:CGFloat, offsetDegrees:CGFloat) -> [CGPoint] {
        let angle = (360 / CGFloat(sides)).radians()
        let offset = offsetDegrees.radians()
        var points = [CGPoint]()
        for i in 0..<sides {
            let x = cx + radius * cos(angle * CGFloat(i) - offset)
            let y = cy + radius * sin(angle * CGFloat(i) - offset)
            points.append(CGPoint(x: x, y: y))
        }
        return points
    }

    public class func distanceSq(_ pt0:CGPoint, _ pt1:CGPoint) -> CGFloat {
        let dx = pt0.x - pt1.x
        let dy = pt0.y - pt1.y
        return dx * dx + dy * dy
    }

    public class func distance(_ pt0:CGPoint, _ pt1:CGPoint) -> CGFloat {
        return distanceSq(pt0, pt1).squareRoot()
    }
}
