import UIKit
import CoreLocation
import Lottie  // Import Lottie for animations

class ViewController: UIViewController, CLLocationManagerDelegate {

    // Outlet for the temperature label and tick/cross icons
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var tickIcon: UIImageView!
    @IBOutlet weak var crossIcon: UIImageView!

    // Lottie animation view
    var animationView: LottieAnimationView?

    // Core Location manager to get the user's location
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Request location permission
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()

        // Hide the tick and cross icons initially
        tickIcon.isHidden = true
        crossIcon.isHidden = true

        // You can check the initial authorization status here if needed
        checkAuthorizationStatus(status: locationManager.authorizationStatus)
    }

    // Called when the authorization status changes
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

            // Fetch weather data based on the location
            fetchWeather(latitude: latitude, longitude: longitude)
        }
    }

    // Fetch weather data from the OpenWeatherMap API
    func fetchWeather(latitude: Double, longitude: Double) {
        let apiKey = "8f1b1c0882335821b5dc24bdca2865a2"  // Your OpenWeatherMap API key
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric"

        if let url = URL(string: urlString) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                           let main = json["main"] as? [String: Any],
                           let temp = main["temp"] as? Double {
                            // Update the UI with the temperature
                            DispatchQueue.main.async {
                                self.updateTemperatureDisplay(temp: temp)
                            }
                        }
                    } catch {
                        print("Error parsing weather data: \(error.localizedDescription)")
                    }
                }
            }
            task.resume()
        }
    }

    // Update the temperature label, show/hide the tick/cross icons, and play the correct animation
    func updateTemperatureDisplay(temp: Double) {
        
        tempLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 65)
        // Set the temperature in the top-right label
        tempLabel.text = "\(Int(temp))°C"

        // Define the temperature threshold for "too hot"
        let hotThreshold = 30.0

        // Remove any existing Lottie animations
        animationView?.removeFromSuperview()

        if temp >= hotThreshold {
            // It's too hot, show the cross icon and hide the tick icon
            crossIcon.isHidden = false
            tickIcon.isHidden = true

            // Load the "dog too hot" animation
            animationView = LottieAnimationView(name: "dogDrinking")  // Use your Lottie file for a dog looking too hot

        } else {
            // It's safe, show the tick icon and hide the cross icon
            tickIcon.isHidden = false
            crossIcon.isHidden = true

            // Load the "dog walking" animation
            animationView = LottieAnimationView(name: "dogWalking")  // Use your Lottie file for a dog walking

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
}
