//
//  ViewControllerTests.swift
//  HotDog
//
//  Created by David Bate on 06/10/2024.
//


import XCTest
@testable import HotDog

class ViewControllerTests: XCTestCase {

    var viewController: ViewController!
    
    override func setUp() {
        super.setUp()
        viewController = ViewController()
        viewController.loadViewIfNeeded()  // Loads the view and outlets
    }
    
    // Test temperature threshold adjustment based on dog size
    func testAdjustTemperatureThreshold() {
        viewController.selectedDogSize = "Small"
        viewController.adjustTemperatureThreshold()
        XCTAssertEqual(viewController.tempThreshold, 25.0, "Temperature threshold should be 25 for small dogs")
        
        viewController.selectedDogSize = "Large"
        viewController.adjustTemperatureThreshold()
        XCTAssertEqual(viewController.tempThreshold, 35.0, "Temperature threshold should be 35 for large dogs")
    }
    
    // Test location update and weather API call
    func testLocationUpdatesFetchWeather() {
        // Mock the location update
        let mockLocation = CLLocation(latitude: 37.7749, longitude: -122.4194) // San Francisco location
        viewController.locationManager(viewController.locationManager, didUpdateLocations: [mockLocation])
        
        // Assert that the weather API was called (you could mock the network call here)
        // For simplicity, you can assert that the correct latitude and longitude were passed.
        XCTAssertNotNil(viewController.tempLabel.text, "Temperature label should be updated")
    }
}
