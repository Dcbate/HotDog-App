//
//  DogSizeViewController.swift
//  HotDog
//
//  Created by David Bate on 06/10/2024.
//

import XCTest
@testable import HotDog

class DogSizeViewControllerTests: XCTestCase {

    var dogSizeViewController: DogSizeViewController!
    
    override func setUp() {
        super.setUp()
        dogSizeViewController = DogSizeViewController()
        dogSizeViewController.loadViewIfNeeded()
    }
    
    // Test that selecting a dog size saves the size to UserDefaults
    func testSelectDogSize() {
        dogSizeViewController.selectedDogSize(size: "Medium")
        
        let savedSize = UserDefaults.standard.string(forKey: "dogSize")
        XCTAssertEqual(savedSize, "Medium", "Dog size should be saved to UserDefaults")
    }
    
    // Test that selecting a dog size navigates to the main screen
    func testNavigateToMainScreen() {
        // Simulate selecting a dog size
        dogSizeViewController.selectedDogSize(size: "Large")
        
        // Assuming you perform a segue after selecting, you can check that the segue was triggered
        // XCTAssertEqual(dogSizeViewController.performSegueCalled, true) // Example if you mock the segue call
    }
}
