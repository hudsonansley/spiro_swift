//
//  spirolateralTests.swift
//  spirolateralTests
//
//  Created by Hudson Ansley on 7/5/19.
//  Copyright © 2019 hlamedia. All rights reserved.
//

import XCTest
@testable import spirolateral

class spirolateralTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDistance() {
        XCTAssertEqual(Polygon.distanceSq(CGPoint(x:0, y:0), CGPoint(x:2, y:2)), 8.0)
        XCTAssertEqual(Polygon.distance(CGPoint(x:0, y:0), CGPoint(x:2, y:2)), CGFloat(8.0.squareRoot()))
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
