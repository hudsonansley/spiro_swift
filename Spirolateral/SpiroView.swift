//
//  SpiroView.swift
//  spirolateral
//
//  Created by Hudson Ansley on 3/31/20.
//  Copyright © 2020 hlamedia. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

struct SpiroView : View {
        var spiroData: Spiro
        var colors:[Color] = [Color(rgb:0xff0000), Color(rgb:0x00ff00), Color(rgb:0x0000ff), Color(rgb:0xffff00), Color(rgb:0x00ffff), Color(rgb:0xff00ff), Color(rgb:0xff8000), Color(rgb:0x00ff80), Color(rgb:0xff0080), Color(rgb:0x80ff00), Color(rgb:0x0080ff), Color(rgb:0x8000ff), Color(rgb:0xffff80), Color(rgb:0x80ffff), Color(rgb:0xff80ff)]
        var lineWidth:CGFloat = 6.0
        var offsetDegrees:CGFloat = 90

        var body: some View {
            GeometryReader { geometry in
                Path { path in
                    let r = Polygon.radius(size:geometry.size)
//                    let rScaled = r * self.scale - self.lineWidth / 2
                    let spiro = Spiro(numberOfTurns:25, wholeCircle: 4, ang: 1)
                    let verts = spiro.spiroVertexList
                    path.move(
                        to: verts[0].point
                    )
                    verts.forEach {
                        path.addLine(
                            to: $0.point
                        )
                    }
                    path.closeSubpath()
                }
                .stroke(self.colors[0], lineWidth: self.lineWidth)
    //            .fill(self.color)
            }
        }
}

struct cycleView : View {
    var spiroData: Spiro
    var color:Color = Color.white
    var lineWidth:CGFloat = 6.0
    var offsetDegrees:CGFloat = 90

    var body: some View {
        Path { path in
        }
    }
}

/*

 private function scaleAndOffset(x:Float, y:Float):Point {
     return new Point((x + center.x)*scale+origin.x, (y + center.y)*scale+origin.y);
 }

 private function drawCycle(sp:Sprite, ?color:UInt = 0, ?lineThickness:Int = 1) {
     var i = 0;
     var pt:Point;
     sp.graphics.lineStyle(lineThickness, color);
     sp.graphics.moveTo(0, 0);
     while (i < numOfTurns) {
         pt = spiroVertexList[i].vertex;
         //trace("pt["+i+"]= ("+pt.x+", "+pt.y+")");
         sp.graphics.lineTo(pt.x * scale, pt.y * scale);
         i++;
     }
 }

 public function drawSpiro() {
     resetSpiro();
     var colors = [0xff0000, 0x00ff00, 0x0000ff, 0xffff00, 0x00ffff, 0xff00ff, 0xff8000, 0x00ff80, 0xff0080, 0x80ff00, 0x0080ff, 0x8000ff, 0xffff80, 0x80ffff, 0xff80ff];
     var numColors = colors.length;
     var theta = 0;
     var sp:Sprite;
     var pt:Point;
     var realAngle;
     var m:openfl.geom.Matrix;
     pt = spiroVertexList[numOfTurns-1].vertex;
     var endPt:Point = new Point(pt.x * scale, pt.y * scale);
     pt = scaleAndOffset(0, 0);
     var i = 0;
     while (i < numOfCycles) {
         sp = new Sprite();
         sp.x = pt.x;
         sp.y = pt.y;
         drawCycle(sp, colors[i % numColors]);
         realAngle = Maths.circleUnitsToRads(theta, wholeCircle);
         sp.rotation = 180 * realAngle / Math.PI;
         //trace("sp.rotation: "+sp.rotation+", circle units: "+theta);
         addChild(sp);
         m = new openfl.geom.Matrix(0,0,0,0,endPt.x,endPt.y);
         m.rotate(realAngle);
         pt.x += m.tx;
         pt.y += m.ty;
         // draw single cycle shape at loc, theta
         // update theta based on angle between cycles (calc in calcSpiro)
         theta = (theta + angle) % wholeCircle;
         i++;
     }

     // cycle colors ???
 }


 */
