//
//  LocationListViewModelTests.swift
//  GeographicTests
//
//  Created by Mustafa Ezzat on 2/10/18.
//  Copyright © 2018 Mustafa Ezzat. All rights reserved.
//

import XCTest
import RxSwift
@testable import Geographic

class LocationListViewModelTests: XCTestCase {
    let locationListViewModel = LocationListViewModel()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetLocationList() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.\
        XCTAssert((locationListViewModel.getLocationList() as Any) is Variable<[LocationViewModel]>)
    }
    
    func testLocationListCount() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.\
        XCTAssert(locationListViewModel.getLocationList().value.count == 10)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
