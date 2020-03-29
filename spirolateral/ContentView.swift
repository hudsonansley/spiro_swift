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
    @State var sideCountInnerValue:CGFloat = 0.125
    @State var sideCountInnerDelta:CGFloat = 0.0
    @State var sideCountOutterDelta:CGFloat = 0.0
    @State var gestureStart:Bool = true
    let minAlpha = 0.1
    let maxAlpha = 1.0
    func computeSideCount(_ value:CGFloat) -> Int {
        return Int(value * CGFloat(maxSideCount - minSideCount)) + minSideCount
    }
    func computeSideValue(_ count:Int) -> CGFloat {
        return CGFloat(count - minSideCount) / CGFloat(maxSideCount - minSideCount)
    }
    func clampValue(_ value:CGFloat) -> CGFloat {
        return max( 0.0, min(1.0, value))
    }
    func fadeDown() -> Void {
        print( "fadeDown")
        UIViewPropertyAnimator(duration: 1.0, curve: .easeOut, animations: {
            let x = self.body.opacity(self.minAlpha)
        }).startAnimation()
    }
    func fadeUp() -> Void {
        print( "fadeUp")
        UIViewPropertyAnimator(duration: 2.0, curve: .easeOut, animations: {
            _ = self.body.opacity(self.maxAlpha)
        }).startAnimation()
    }

    var body: some View {
        var alphaFade = minAlpha
        var innerValue = clampValue( sideCountInnerValue + sideCountInnerDelta)
        var outterValue = clampValue( sideCountOutterValue + sideCountOutterDelta)
        if (sideCountInnerDelta > 0 && outterValue < innerValue) {
            outterValue = innerValue
        }
        if (sideCountOutterDelta < 0 && innerValue > outterValue) {
            innerValue = outterValue
        }
        let innerSlideCount = computeSideCount(innerValue)
        let outterSlideCount = computeSideCount(outterValue)
        return VStack {
            GeometryReader { geometry in
            ZStack {
                PolygonView(sideCount: outterSlideCount, scale:CGFloat(self.outterScale), color:Color.blue)
                PolygonView(sideCount: innerSlideCount, scale:CGFloat(self.innerScale), color:Color.red)
            }
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged {drag in
                        if self.gestureStart {
                            self.fadeUp()
                        }
                        self.gestureStart = false
                        let r = Polygon.radius(size:geometry.size)
                        let startDist = Polygon.distance(CGPoint(x:r, y:r), drag.startLocation)
                        let currentDist = Polygon.distance(CGPoint(x:r, y:r), drag.location)
                        let dragDist = Polygon.distance(drag.startLocation, drag.location)
                        var delta = (currentDist - startDist)
                        if (delta < 0 && dragDist > -delta) {
                            delta = -dragDist
                        }
                        if (startDist / r) < self.innerScale {
                            self.sideCountInnerDelta = delta / r
                        } else {
                            self.sideCountOutterDelta = delta / r
                        }
                }
                .onEnded { _ in
                    self.sideCountInnerValue = self.computeSideValue(innerSlideCount)
                    self.sideCountInnerDelta = 0.0
                    self.sideCountOutterValue = self.computeSideValue(outterSlideCount)
                    self.sideCountOutterDelta = 0.0
                    self.fadeDown()
                    self.gestureStart = true
                }
                )
            }
        }.onAppear(perform: fadeDown)
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
            Slider(value: $value, in: 0.0...1.0, step: 0.05)
            Text("\(maxCount)")
        }
        .padding()
    }
}
