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

    public class func vertices(sides:Int, cx:CGFloat, cy:CGFloat, radius:CGFloat, offsetDegrees:CGFloat) -> [CGPoint] {
        let angle = (360 / CGFloat(sides)).radians()
        let offset = offsetDegrees.radians()
        let points = (0..<sides).map{
            CGPoint(
                x: cx + radius * cos(angle * CGFloat($0) - offset),
                y: cy + radius * sin(angle * CGFloat($0) - offset)
            )
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

    public class func radius(size: CGSize) -> CGFloat {
        return min(size.width, size.height) / 2.0
    }
}
