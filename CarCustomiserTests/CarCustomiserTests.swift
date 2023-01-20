//
//  CarCustomiserTests.swift
//  CarCustomiserTests
//
//  Created by Fiennes Harris on 12/01/2023.
//

import XCTest
@testable import CarCustomiser

final class CarCustomiserTests: XCTestCase {
    func testNewCarGivesMeACarWithAllAttributesSet() {
        let car = Car(make: "BMW", model: "X3", topSpeed: 130, acceleration: 8.4, handling: 7)
        
        XCTAssertEqual(car.make, "BMW")
        XCTAssertEqual(car.model, "X3")
        XCTAssertEqual(car.topSpeed, 130)
        XCTAssertEqual(car.acceleration, 8.4)
        XCTAssertEqual(car.handling, 7)
    }
    
    func testCarCanDisplayAttributes() {
        let car = Car(make: "BMW", model: "X3", topSpeed: 130, acceleration: 8.4, handling: 7)
        let carStats = car.displayStats()
        XCTAssertEqual(carStats.0, "Make: BMW")
        XCTAssertEqual(carStats.1, "Model: X3")
        XCTAssertEqual(carStats.2, "Top speed: 130mph")
        XCTAssertEqual(carStats.3, "Acceleration (0-60): 8.4s")
        XCTAssertEqual(carStats.4, "Handling: 7")
    }
}

