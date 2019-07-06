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
    @State var sideCountOutterValue:Double = 0.5
    @State var sideCountInnerValue:Double = 0.5
    func computeSideCount(_ value:Double, min:Int, max:Int) -> Int {
        return Int(value * Double(max - min)) + min
    }
    var body: some View {
        let innerSlideCount = computeSideCount(sideCountInnerValue, min:minSideCount, max:maxSideCount)
        let outterSlideCount = computeSideCount(sideCountOutterValue, min:innerSlideCount, max:maxSideCount)
        return VStack {
            PolygonView(sideCount: innerSlideCount, scale:CGFloat(0.8), color:Color.red)
            PolygonView(sideCount: outterSlideCount, scale:CGFloat(1.0), color:Color.blue)
            SideSlider(value: $sideCountInnerValue, minCount:minSideCount, maxCount:maxSideCount)
            SideSlider(value: $sideCountOutterValue, minCount:innerSlideCount, maxCount:maxSideCount)
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
    @Binding var value: Double
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
