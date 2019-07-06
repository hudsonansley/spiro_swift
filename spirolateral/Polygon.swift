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

extension Double {
    func radians() -> Double {
        return .pi * self / 180.0
    }
}

class Polygon:NSObject {

public class func pointArray(sides:Int,x:Double,y:Double,radius:Double,offset:Double)->[CGPoint] {
    let angle = (360/Double(sides)).radians()
    let cx = x // x origin
    let cy = y // y origin
    let r = radius // radius of circle
    var i = 0
    var points = [CGPoint]()
    while i <= sides {
        let xpo = cx + r * cos(angle * Double(i) - offset.radians())
        let ypo = cy + r * sin(angle * Double(i) - offset.radians())
        points.append(CGPoint(x: xpo, y: ypo))
        i += 1
    }
    return points
}

private class func path(x:Double, y:Double, radius:Double, sides:Int, offset: Double = 0.0) -> CGPath {
    let path = CGMutablePath()
    let points = Polygon.pointArray(sides: sides,x: x,y: y,radius: radius, offset: offset)
    let cpg = points[0]
    path.move(to: cpg)
    for p in points {
        path.addLine(to: p)
    }
    path.closeSubpath()
    return path
}

func drawPolygonBezier(x:Double, y:Double, radius:Double, sides:Int, color:UIColor, offset:Double) -> UIBezierPath {
    let path = Polygon.path(x: x, y: y, radius: radius, sides: sides, offset: offset)
    let bez = UIBezierPath(cgPath: path)
    // no need to convert UIColor to CGColor when using UIBezierPath
    color.setFill()
    bez.fill()
    return bez
}

func drawPolygonUsingPath(ctx:CGContext, x:Double, y:Double, radius:Double, sides:Int, color:UIColor, offset:Double) {
    let path = Polygon.path(x: x, y: y, radius: radius, sides: sides, offset: offset)
    ctx.addPath(path)
    let cgcolor = color.cgColor
//    ctx.setFillColor(cgcolor)
    ctx.setStrokeColor(cgcolor)
//    ctx.fillPath()
    ctx.setLineWidth(4.0)
    ctx.strokePath()
}

func drawPolygon(ctx:CGContext, x:Double, y:Double, radius:Double, sides:Int, color:UIColor, offset:Double) {

    let points = Polygon.pointArray(sides: sides,x: x,y: y,radius: radius, offset: offset)
    ctx.addLines(between: points)
    let cgcolor = color.cgColor
    ctx.setFillColor(cgcolor)
    ctx.fillPath()
}
class func makeShapeLayer(x:Double, y:Double, radius:Double, sides:Int, color:UIColor, offset:Double = 0.0) -> CAShapeLayer {

    let shape = CAShapeLayer()
    shape.path = Polygon.path(x: x, y: y, radius: radius, sides: sides, offset: offset)
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
