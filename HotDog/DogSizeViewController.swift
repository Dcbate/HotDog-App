//
//  DogSizeViewController.swift
//  HotDog
//
//  Created by David Bate on 06/10/2024.
//

import UIKit

class DogSizeViewController: UIViewController {
    
    // Variable to store the selected dog size
    var selectedDogSize: String?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func selectSmallDog(_ sender: UIButton) {
        print("Small dog selected")  // Debugging message
        selectedDogSize = "Small"
        saveDogSize(size: "Small")
        navigateToMainStoryboard()
    }

    @IBAction func selectMediumDog(_ sender: UIButton) {
        print("Medium dog selected")  // Debugging message
        selectedDogSize = "Medium"
        saveDogSize(size: "Medium")
        navigateToMainStoryboard()
    }

    @IBAction func selectLargeDog(_ sender: UIButton) {
        print("Large dog selected")  // Debugging message
        selectedDogSize = "Large"
        saveDogSize(size: "Large")
        navigateToMainStoryboard()
    }
    

    // Save the selected dog size using UserDefaults
    func saveDogSize(size: String) {
        // Save the dog size to UserDefaults
        UserDefaults.standard.set(size, forKey: "dogSize")
    }

    func navigateToMainStoryboard() {
        print("navigateToMainStoryboard")  // Debugging message

        // Load the Main storyboard programmatically
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // Instantiate the ViewController (main screen)
        if let mainVC = storyboard.instantiateInitialViewController() as? ViewController {
            
            // Pass the selected dog size
            mainVC.selectedDogSize = selectedDogSize
            
            // Present the view controller
            mainVC.modalPresentationStyle = .fullScreen
            mainVC.modalTransitionStyle = .crossDissolve
            self.present(mainVC, animated: true, completion: nil)
        } else {
            print("Failed to instantiate the Main storyboard")
        }
    }
}
