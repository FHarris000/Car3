//
//  CarCustomiserUITests.swift
//  CarCustomiserUITests
//
//  Created by Fiennes Harris on 12/01/2023.
//

import XCTest

final class CarCustomiserUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testWhenBoughtTiresAndExhaustPackageOtherTwoUpgradesAreDisabled() throws {
      
        let app = XCUIApplication()
        app.launch()
        
        let collectionViewsQuery = app.collectionViews
        
        let exhaustPackageCost500Switch = collectionViewsQuery/*@START_MENU_TOKEN@*/.switches["Exhaust Package (Cost: 500)"]/*[[".cells.switches[\"Exhaust Package (Cost: 500)\"]",".switches[\"Exhaust Package (Cost: 500)\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        exhaustPackageCost500Switch.tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.switches["Grip Package (Cost: 500)"]/*[[".cells.switches[\"Grip Package (Cost: 500)\"]",".switches[\"Grip Package (Cost: 500)\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
         
        XCTAssertEqual(collectionViewsQuery/*@START_MENU_TOKEN@*/.switches["Speedy wheels (Cost: 500)"]/*[[".cells.switches[\"Speedy wheels (Cost: 500)\"]",".switches[\"Speedy wheels (Cost: 500)\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.isEnabled, false)
        XCTAssertEqual(collectionViewsQuery/*@START_MENU_TOKEN@*/.switches["Upgrade all stats (Cost: 1000)"]/*[[".cells.switches[\"Upgrade all stats (Cost: 1000)\"]",".switches[\"Upgrade all stats (Cost: 1000)\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.isEnabled, false)
        
    }
    
    func testWhenNextCarPressed6TimesThatItLoops() throws {
        let car = StarterCars().cars
        var currentCarIndex = 0
        let app = XCUIApplication()
        app.launch()
        
        let nextCarButton = XCUIApplication().collectionViews/*@START_MENU_TOKEN@*/.buttons["Next Car"]/*[[".cells.buttons[\"Next Car\"]",".buttons[\"Next Car\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let starterCar = car[currentCarIndex].make
        for i in 1 ... 6 {
            nextCarButton.tap()
            if currentCarIndex < car.count-1 {
                currentCarIndex += 1
            } else {
                currentCarIndex = 0
            }
            
        }
        XCTAssertEqual(starterCar, car[currentCarIndex].make)
        
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
