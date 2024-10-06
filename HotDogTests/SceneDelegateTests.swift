//
//  SceneDelegateTests.swift
//  HotDog
//
//  Created by David Bate on 06/10/2024.
//

import XCTest
@testable import HotDog

class SceneDelegateTests: XCTestCase {
    
    var sceneDelegate: SceneDelegate!
    
    override func setUp() {
        super.setUp()
        sceneDelegate = SceneDelegate()
    }
    
    // Test that DogSizeViewController is loaded when no dog size is saved
    func testLoadDogSizeViewControllerIfNoSizeSaved() {
        UserDefaults.standard.removeObject(forKey: "dogSize")  // Ensure no dog size is saved

        let windowScene = UIWindowScene(session: UISceneSession(), connectionOptions: UIScene.ConnectionOptions())
        sceneDelegate.window = UIWindow(windowScene: windowScene)
        sceneDelegate.scene(windowScene, willConnectTo: UISceneSession(), options: UIScene.ConnectionOptions())
        
        XCTAssertTrue(sceneDelegate.window?.rootViewController is DogSizeViewController, "DogSizeViewController should be loaded if no size is saved")
    }

    // Test that ViewController is loaded when a dog size is saved
    func testLoadMainViewControllerIfSizeSaved() {
        UserDefaults.standard.set("Medium", forKey: "dogSize")  // Simulate saving a dog size
        
        let windowScene = UIWindowScene(session: UISceneSession(), connectionOptions: UIScene.ConnectionOptions())
        sceneDelegate.window = UIWindow(windowScene: windowScene)
        sceneDelegate.scene(windowScene, willConnectTo: UISceneSession(), options: UIScene.ConnectionOptions())
        
        XCTAssertTrue(sceneDelegate.window?.rootViewController is ViewController, "ViewController should be loaded if a size is saved")
    }
}
