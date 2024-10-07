import UIKit
import CoreLocation
import WeatherKit // Make sure WeatherKit is imported
import Lottie

@available(iOS 16.0, *)
class ViewController: UIViewController, CLLocationManagerDelegate {

    // Outlet for the temperature label and tick/cross icons
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var tickIcon: UIImageView!
    @IBOutlet weak var crossIcon: UIImageView!

    // Lottie animation view
    var animationView: LottieAnimationView?

    // Variable to store the selected dog size
    var selectedDogSize: String?

    // Core Location manager to get the user's location
    let locationManager = CLLocationManager()

    // Temperature threshold for dog walking
    var tempThreshold: Double = 30.0  // Default threshold
    
    // To prevent continuous updates
    var lastWeatherFetchTime: Date?

    // Weather service
    let weatherService = WeatherService()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Request location permission
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()

        // Set a distance filter to avoid too frequent updates
        locationManager.distanceFilter = 500  // Only update location after moving 500 meters

        // Hide the tick and cross icons initially
        tickIcon.isHidden = true
        crossIcon.isHidden = true

        // Adjust temperature threshold based on the selected dog size
        adjustTemperatureThreshold()

        // Check initial authorization status
        checkAuthorizationStatus(status: locationManager.authorizationStatus)
    }

    // Adjust the temperature threshold based on the selected dog size
    func adjustTemperatureThreshold() {
        switch selectedDogSize {
        case "Small":
            tempThreshold = 25.0  // Example threshold for small dogs
        case "Medium":
            tempThreshold = 30.0  // Default threshold for medium dogs
        case "Large":
            tempThreshold = 35.0  // Example threshold for large dogs
        default:
            tempThreshold = 30.0  // Default threshold
        }
    }

    // CLLocationManager Delegate: called when the authorization status changes
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = manager.authorizationStatus
        checkAuthorizationStatus(status: status)
    }

    // Helper function to handle location authorization status
    func checkAuthorizationStatus(status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            // Start updating location if authorized
            if CLLocationManager.locationServicesEnabled() {
                locationManager.startUpdatingLocation()
            }
        case .denied, .restricted:
            print("Location services are not allowed.")
        case .notDetermined:
            print("Waiting for user to allow location access.")
        @unknown default:
            print("Unknown location authorization status.")
        }
    }

    // CLLocationManager Delegate: called when the location is updated
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude

            // Ensure we only fetch weather data at intervals (e.g., every 5 minutes)
            let currentTime = Date()
            if let lastFetch = lastWeatherFetchTime, currentTime.timeIntervalSince(lastFetch) < 300 {
                // Less than 5 minutes since the last fetch, so skip fetching the weather
                print("Skipping fetch, last weather fetch was less than 5 minutes ago.")
                return
            }

            // Update the last fetch time
            lastWeatherFetchTime = currentTime

            // Fetch weather data based on the location using WeatherKit
            fetchWeather(latitude: latitude, longitude: longitude)
        }
    }

    // Fetch weather data using WeatherKit
    func fetchWeather(latitude: Double, longitude: Double) {
        Task {
            do {
                let location = CLLocation(latitude: latitude, longitude: longitude)
                let weather = try await weatherService.weather(for: location)

                // Access current weather data
                let tempCelsius = weather.currentWeather.temperature.value
                DispatchQueue.main.async {
                    self.updateTemperatureDisplay(temp: tempCelsius)
                }
            } catch {
                print("Error fetching weather data: \(error)")
            }
        }
    }

    // Update the temperature label, show/hide the tick/cross icons, and play the correct animation
    func updateTemperatureDisplay(temp: Double) {
        tempLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 65)
        // Set the temperature in the top-right label
        tempLabel.text = "\(Int(temp))°C"

        // Remove any existing Lottie animations
        animationView?.removeFromSuperview()

        // Check if the temperature is above the threshold
        if temp >= tempThreshold {
            // It's too hot, show the cross icon and hide the tick icon
            crossIcon.isHidden = false
            tickIcon.isHidden = true

            // Load the "dog too hot" animation
            animationView = LottieAnimationView(name: "dogDrinking")
        } else {
            // It's safe, show the tick icon and hide the cross icon
            tickIcon.isHidden = false
            crossIcon.isHidden = true

            // Load the "dog walking" animation
            animationView = LottieAnimationView(name: "dogWalking")
        }

        // Set the animation view size and position
        if let animationView = animationView {
            animationView.loopMode = .loop
            animationView.backgroundBehavior = .forceFinish  // Use Main Thread rendering
            animationView.frame = CGRect(x: 0, y: 300, width: 400, height: 400)  // Adjust the frame as needed
            animationView.center.x = self.view.center.x  // Center it horizontally
            self.view.addSubview(animationView)
            animationView.play()
        }
    }

    // Handle location errors
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
    
    
    
    @IBAction func resetDogSize(_ sender: UIButton) {
        // Clear the saved dog size from UserDefaults
        UserDefaults.standard.removeObject(forKey: "dogSize")
        
        // Load the Dog Selection screen
        let storyboard = UIStoryboard(name: "DogSelection", bundle: nil)
        if let selectionVC = storyboard.instantiateViewController(identifier: "DogSizeViewController") as? DogSizeViewController {
            print("navigateToDogSizeViewController")
            selectionVC.modalPresentationStyle = .fullScreen
            selectionVC.modalTransitionStyle = .crossDissolve
            self.present(selectionVC, animated: true, completion: nil)
        }
    }
}
