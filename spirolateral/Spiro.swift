//
//  Spiro.swift
//  spirolateral
//
//  Created by Hudson Ansley on 3/29/20.
//  Copyright © 2020 hlamedia. All rights reserved.
//

import Foundation
import CoreGraphics

struct Spiro {
    init(numberOfTurns _numberOfTurns: Int, wholeCircle: Int, ang:Int, randomTurns:Bool = true) {
        var numberOfTurns = _numberOfTurns
        var theta:Int = 0
        var turns = [Int]()
        var pt:CGPoint = .zero
        var realAngle:CGFloat = 0.0
        var i:Int = 0
        while (i < numberOfTurns || theta == 0) {
            if randomTurns {
                turns[i] = Int.random(in: 0...1) * 2 - 1
                if i >= numberOfTurns && ((turns[i] * ang) % wholeCircle) == 0 {
                    turns[i] = 1;
                }
            } else {
                turns[i] = 1
            }
            pt.x += CGFloat(i + 1) * cos(realAngle);
            pt.y += CGFloat(i + 1) * sin(realAngle);
            theta = ((turns[i] * ang) + theta) % wholeCircle;
            realAngle = Polygon.circleUnitsToRads(theta, wholeCircle: wholeCircle);
            i += 1;
        }
        numberOfTurns = i;
        angle = theta;

        spiroVertexList = []
        cycleCount = 1
        regPoint = .zero
    }
    let spiroVertexList: [CGPoint]
    let angle: Int
    var turnCount: Int {
        get {
            return spiroVertexList.count
        }
    }
    let cycleCount: Int
    let regPoint: CGPoint
}



/*

 public function calcSpiro(pNumOfTurns:Int, pWholeCircle:Int, ang:Int, randomTurns:Bool = true) {
     wholeCircle = pWholeCircle;
     numOfTurns = pNumOfTurns;
     var theta = 0;
     turns = new Array<Int>();
     var pt = new Point( 0.0,0.0);
     var realAngle:Float;
     realAngle = 0.0;
     var i = 0;
     while ((i < numOfTurns) || (theta == 0)) {
         if (randomTurns) {
             turns[i] = Math.floor(Math.random() * 2) * 2 - 1;
             if (i >= numOfTurns) {
                 if (((turns[i] * ang) % wholeCircle) == 0) {
                     turns[i] = 1;
                 }
             }
         } else {
             turns[i] = 1;
         }
         pt.x += (i+1) * Math.cos(realAngle);
         pt.y += (i+1) * Math.sin(realAngle);
         theta = ((turns[i] * ang) + theta) % wholeCircle;
         realAngle = Maths.circleUnitsToRads(theta, wholeCircle);
         i++;
     }
     numOfTurns = i;
     angle = theta;
     //angle = (turns[numOfTurns-1] * ang) % wholeCircle;
     //realAngle = Maths.circleUnitsToRads(angle);
     trace("cycle angle:"+angle);
     trace("endPt: ("+pt.x+", "+pt.y+")");
     numOfCycles = Std.int(wholeCircle / Maths.GCF(wholeCircle, theta));
     var phi;
     var chi;
     var r;
     var tx = pt.x;
     var ty = pt.y;
     if ( tx == 0.0 ) {
         if (ty < 0.0) {
             phi = - Math.PI / 2;
         } else {
             phi = Math.PI / 2;
         }
     } else if (tx < 0.0) {
         phi = Math.PI + Math.atan( ty / tx );
     } else {
         phi = Math.atan( ty / tx );
     }
     chi = Maths.fmod ( ( Math.PI - realAngle ) / 2, Math.PI );
     r = - Math.sqrt( tx * tx + ty * ty ) / 2 / Math.cos(chi);
     center = new Point(r * Math.cos(phi + chi), r * Math.sin(phi + chi));
     pt = new Point(0.0,0.0); // center; //
     spiroVertexList = new Array<Vertex>();
     //spiroVertexList.push({vertex:new Point(0,0)});
     r = 0.0;
     theta = 0;
     var vert:Vertex;
     var t1;
     var t2;
     var lastTheta = 0;
     var deltaAngle;
     var tAng = 0.0;
     var realAngle = 0.0;
     var temp;
     i = 0;
     while (i < numOfTurns) {
         lastTheta = theta;
         pt.x += (i+1) * Math.cos(realAngle);
         pt.y += (i+1) * Math.sin(realAngle);
         theta = ((turns[i] * ang) + theta) % wholeCircle;
         //trace("turns["+i+"]="+turns[i]+", angle: "+theta+", realAngle: "+realAngle);
         realAngle = Maths.circleUnitsToRads(theta, wholeCircle);
         vert = {vertex:pt.clone()};
         if (rounded) {
             deltaAngle = theta - lastTheta;
             if  (deltaAngle < 0) {
                 t1 = lastTheta + Std.int(( deltaAngle) / 2.0 - (wholeCircle / 4.0));
                 t2 = lastTheta + Std.int(( deltaAngle) / 2.0 + (wholeCircle / 4.0));
             } else {
                 t1 = lastTheta + Std.int(( deltaAngle) / 2.0 + (wholeCircle / 4.0));
                 t2 = lastTheta + Std.int(( deltaAngle) / 2.0 - (wholeCircle / 4.0));
             }
             tAng = Maths.circleUnitsToRads(t1, wholeCircle);
             vert.handle1  = new Point(( (i +2) / handleScale) * Math.cos(tAng), ( (i +2) / handleScale) * Math.sin(tAng));
             tAng = Maths.circleUnitsToRads(t2, wholeCircle);
             vert.handle2 = new Point(( (i +1) / handleScale) * Math.cos(tAng), ( (i+1)  / handleScale) * Math.sin(tAng));
         }
         spiroVertexList.push( vert);
         tx = pt.x + center.x;
         ty = pt.y + center.y;
         temp = tx * tx + ty * ty;
         if (temp > r) {
             r = temp;
         }
         i++;
     }
     r = Math.sqrt(r);
     scale = size / r / 2;
     regPoint = new Point(scale * center.x, scale * center.y);
     //graphics.lineStyle(3, 0);
     //graphics.drawCircle(size/2, size/2, r * scale);

 }

 */
