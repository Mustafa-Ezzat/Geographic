//
//  LocationManagerTests.swift
//  GeographicTests
//
//  Created by Mustafa Ezzat on 2/11/18.
//  Copyright © 2018 Mustafa Ezzat. All rights reserved.
//

import XCTest
import GoogleMaps
@testable import Geographic

class LocationManagerTests: XCTestCase {
    let locationListViewModel = LocationListViewModel()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCreateLocation() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.\
        for location in locationListViewModel.getLocationList().value{
            let locationCoordinate = LocationManager.sharedInstance.createLocation(locationViewModel: location)
            XCTAssert(!(locationCoordinate.latitude == -1 || locationCoordinate.longitude == -1))
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
