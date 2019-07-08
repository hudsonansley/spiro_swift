//
//  ContentView.swift
//  spirolateral
//
//  Created by Hudson Ansley on 7/5/19.
//  Copyright © 2019 hlamedia. All rights reserved.
//

import SwiftUI
import CoreGraphics

struct ContentView : View {
    let minSideCount = 3
    let maxSideCount = 36
    let outterScale:CGFloat = 1.0
    let innerScale:CGFloat = 0.5
    @State var sideCountOutterValue:CGFloat = 0.5
    @State var sideCountInnerValue:CGFloat = 0.5
    func computeSideCount(_ value:CGFloat, min:Int, max:Int) -> Int {
        return Int(value * CGFloat(max - min)) + min
    }
    func computeSideValue(_ count:Int, min:Int, max:Int) -> CGFloat {
        return CGFloat(count - min) / CGFloat(max - min)
    }
    func clampValue(_ value:CGFloat) -> CGFloat {
        return max( 0.0, min(1.0, value))
    }
    @State var sideCountInnerDelta:CGFloat = 0.0
    @State var sideCountOutterDelta:CGFloat = 0.0
    var body: some View {
        var innerValue = clampValue( sideCountInnerValue + sideCountInnerDelta)
        var outterValue = clampValue( sideCountOutterValue + sideCountOutterDelta)
        if (sideCountInnerDelta > 0 && outterValue < innerValue) {
            outterValue = innerValue
        }
        if (sideCountOutterDelta < 0 && innerValue > outterValue) {
            innerValue = outterValue
        }
        let innerSlideCount = computeSideCount(innerValue, min:minSideCount, max:maxSideCount)
        let outterSlideCount = computeSideCount(outterValue, min:minSideCount, max:maxSideCount)
        return VStack {
            GeometryReader { geometry in

            ZStack {
                PolygonView(sideCount: outterSlideCount, scale:CGFloat(self.outterScale), color:Color.blue)
                PolygonView(sideCount: innerSlideCount, scale:CGFloat(self.innerScale), color:Color.red)
            }
            .gesture(
                DragGesture(minimumDistance: 10)
                    .onChanged {drag in
                        let r = CGFloat(min(geometry.size.width, geometry.size.height) / 2)
                        let startDist = Polygon.distance(CGPoint(x:r, y:r), drag.startLocation)
                        let currentDist = Polygon.distance(CGPoint(x:r, y:r), drag.location)
                        let delta = (currentDist - startDist) / r
                        if (startDist / r) < self.innerScale {
                            self.sideCountInnerDelta = delta
                        } else {
                            self.sideCountOutterDelta = delta
                        }

                        print("Dragging \(self.sideCountInnerDelta) \(startDist / r)")
                }
                .onEnded { _ in
                    self.sideCountInnerValue = self.computeSideValue(innerSlideCount, min:self.minSideCount, max:self.maxSideCount)
                    self.sideCountInnerDelta = 0.0
                    self.sideCountOutterValue = self.computeSideValue(outterSlideCount, min:self.minSideCount, max:self.maxSideCount)
                    self.sideCountOutterDelta = 0.0
                }
                )
            }
        }
    }
}

#if DEBUG
//struct ContentView_Previews : PreviewProvider {
//    static var previews: some View {
//        ContentView(sideCount: 0.5)
//    }
//}
#endif

struct SideSlider : View {
    @Binding var value: CGFloat
    var minCount: Int
    var maxCount: Int
    var body: some View {
        return HStack {
            Text("\(minCount)")
            Slider(value: $value, from: 0.0, through: 1.0)
            Text("\(maxCount)")
        }
        .padding()
    }
}
