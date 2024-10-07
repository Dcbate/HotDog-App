import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        // Check if the dog size is already saved in UserDefaults
        let savedDogSize = UserDefaults.standard.string(forKey: "dogSize")

        // Create a delay of 2 seconds to simulate the launch screen display time
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            // Load the appropriate view controller after the delay
            if savedDogSize != nil {
                print("// If dog size is saved, load the Main screen (weather screen)")
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let mainVC = storyboard.instantiateViewController(identifier: "ViewController") as! ViewController
                self.window = UIWindow(windowScene: windowScene)
                self.window?.rootViewController = mainVC
            } else {
                print("// If no dog size is saved, load the Dog Selection screen")
                let storyboard = UIStoryboard(name: "DogSelection", bundle: nil)
                let selectionVC = storyboard.instantiateViewController(identifier: "DogSizeViewController") as! DogSizeViewController
                self.window = UIWindow(windowScene: windowScene)
                self.window?.rootViewController = selectionVC
            }

            self.window?.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) { /* ... */ }

    func sceneDidBecomeActive(_ scene: UIScene) { /* ... */ }

    func sceneWillResignActive(_ scene: UIScene) { /* ... */ }

    func sceneWillEnterForeground(_ scene: UIScene) { /* ... */ }

    func sceneDidEnterBackground(_ scene: UIScene) { /* ... */ }

}
