//
//  Polygon.swift
//  spirolateral
//
//  Created by Hudson Ansley on 7/5/19.
//  Copyright © 2019 hlamedia. All rights reserved.
//
// code adapted from http://sketchytech.blogspot.com/2014/11/swift-drawing-regular-polygons-with.html

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
    let angle = (360/CGFloat(sides)).radians()
    let offset = offsetDegrees.radians()
    var points = [CGPoint]()
    for i in 0...sides {
        let x = cx + radius * cos(angle * CGFloat(i) - offset)
        let y = cy + radius * sin(angle * CGFloat(i) - offset)
        points.append(CGPoint(x: x, y: y))
    }
    return points
}

private class func path(x:CGFloat, y:CGFloat, radius:CGFloat, sides:Int, offsetDegrees: CGFloat = 0.0) -> CGPath {
    let path = CGMutablePath()
    let points = Polygon.pointArray(sides: sides,cx: x,cy: y,radius: radius, offsetDegrees: offsetDegrees)
    let cpg = points[0]
    path.move(to: cpg)
    for p in points {
        path.addLine(to: p)
    }
    path.closeSubpath()
    return path
}

func drawPolygonBezier(x:CGFloat, y:CGFloat, radius:CGFloat, sides:Int, color:UIColor, offsetDegrees:CGFloat) -> UIBezierPath {
    let path = Polygon.path(x: x, y: y, radius: radius, sides: sides, offsetDegrees: offsetDegrees)
    let bez = UIBezierPath(cgPath: path)
    // no need to convert UIColor to CGColor when using UIBezierPath
    color.setFill()
    bez.fill()
    return bez
}

func drawPolygonUsingPath(ctx:CGContext, x:CGFloat, y:CGFloat, radius:CGFloat, sides:Int, color:UIColor, offsetDegrees:CGFloat) {
    let path = Polygon.path(x: x, y: y, radius: radius, sides: sides, offsetDegrees: offsetDegrees)
    ctx.addPath(path)
    let cgcolor = color.cgColor
//    ctx.setFillColor(cgcolor)
    ctx.setStrokeColor(cgcolor)
//    ctx.fillPath()
    ctx.setLineWidth(4.0)
    ctx.strokePath()
}

func drawPolygon(ctx:CGContext, x:CGFloat, y:CGFloat, radius:CGFloat, sides:Int, color:UIColor, offsetDegrees:CGFloat) {

    let points = Polygon.pointArray(sides: sides,cx: x,cy: y,radius: radius, offsetDegrees: offsetDegrees)
    ctx.addLines(between: points)
    let cgcolor = color.cgColor
    ctx.setFillColor(cgcolor)
    ctx.fillPath()
}
class func makeShapeLayer(x:CGFloat, y:CGFloat, radius:CGFloat, sides:Int, color:UIColor, offsetDegrees:CGFloat = 0.0) -> CAShapeLayer {

    let shape = CAShapeLayer()
    shape.path = Polygon.path(x: x, y: y, radius: radius, sides: sides, offsetDegrees: offsetDegrees)
    shape.strokeColor = color.cgColor
    return shape

}


//class View: UIView {
//
//
//    override func draw(_ rect:CGRect)
//
//    {
//
//        let ctx = UIGraphicsGetCurrentContext()
//
//        drawPolygonUsingPath(ctx: ctx!, x: rect.midX,y: rect.midY,radius: rect.width/3, sides: 3, color: UIColor.blue, offset:0)
//
//        drawPolygonBezier(x: rect.midX,y: rect.midY,radius: rect.width/4, sides: 4, color: UIColor.yellow, offset:0)
//
//        drawPolygon(ctx: ctx!, x: rect.midX,y: rect.midY,radius: rect.width/5, sides: 6, color: UIColor.green, offset:0)
//
//    }
//}
//
//View(frame: CGRect(x: 0, y: 0, width: 200, height: 200))

}
