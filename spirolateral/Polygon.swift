//
//  Polygon.swift
//  spirolateral
//
//  Created by Hudson Ansley on 7/5/19.
//  Copyright © 2019 hlamedia. All rights reserved.
//

import Foundation
import CoreGraphics

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

    private class func convertCircleUnits(_ units:Int, wholeCircleValue:CGFloat, wholeCircleDegrees:Int = 360) -> CGFloat {
        return wholeCircleValue * CGFloat(units % wholeCircleDegrees) / CGFloat(wholeCircleDegrees)
    }

    public class func circleUnitsToRads(_ units:Int, wholeCircle:Int = 360) -> CGFloat {
        return convertCircleUnits(units, wholeCircleValue: 2.0 * .pi, wholeCircleDegrees:wholeCircle)
    }

    public class func circleUnitsToDegrees(_ units:Int, wholeCircle:Int = 360) -> CGFloat {
        return convertCircleUnits(units, wholeCircleValue:360.0, wholeCircleDegrees:wholeCircle)
    }

    public class func GCF(_ _a:Int,_ _b:Int) -> Int {
        var temp:Int
        var a = _a
        var b = _b
        while (b != 0) {
            temp = b
            b = a % b
            a = temp
        }
        return abs(a)
    }

    public class func fmod(_ a:CGFloat, _ _b:CGFloat) -> CGFloat {
        var result:CGFloat = 0.0
        let b = abs(_b)
        if (b != 0.0) {
            result = a - b * floor(a / b)
            if result < 0.0 {
                result += b
            }
        }
        return result
    }
}
