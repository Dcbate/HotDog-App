# 🐶 Hot Dog - Dog Walking Assistant

**Hot Dog** is a simple and fun app that helps dog owners decide whether it's safe to walk their dogs based on the current weather conditions in their location. The app uses **Apple's WeatherKit** to fetch weather data and checks whether the temperature is suitable for a walk based on the size of the dog.

## Features

- 🌍 **Location-Based Weather**: The app uses your current location to fetch real-time weather data.
- 🐕 **Custom Dog Size Settings**: Users can choose between small, medium, or large dog sizes. This choice affects the temperature threshold for safe walking.
- 🌡️ **Temperature Display**: The current temperature is displayed prominently, along with animations to indicate if it’s safe to walk your dog.
- ✅ **Green Tick/Red Cross Alerts**: Visual indicators show whether it’s too hot to walk your dog.
- 🎥 **Fun Animations**: Lottie animations of dogs walking (safe) or resting (too hot) to make the experience fun and engaging.
- 🏳️ **Reset Dog Size**: You can reset your selected dog size and choose again when needed.

## Requirements

- Xcode 14+
- iOS 16.0+ (WeatherKit requires iOS 16.0+)
- Swift 5.0+
- **Apple Developer Account** for using **WeatherKit** (you'll need to add WeatherKit entitlement and set up a provisioning profile).

## Technologies Used

- **Swift**
- **WeatherKit** for fetching weather data
- **CoreLocation** for determining the user's current location
- **Lottie** for smooth, fun animations
- **UserDefaults** for saving user preferences (e.g., dog size)

## Setup Instructions

### 1. Clone the Repository

Clone the repository to your local machine using Git.

### 2. Open the Project

Open the `.xcodeproj` file in **Xcode**.

### 3. Configure WeatherKit

- Make sure you have an **Apple Developer Account** and have set up **WeatherKit** in your **App ID**.
- Ensure that **WeatherKit** entitlement is enabled for your app in the provisioning profile.
- Re-generate your provisioning profile after enabling WeatherKit.

### 4. Install Dependencies

If using **Lottie**, include it via **Swift Package Manager**. In Xcode, go to **File** -> **Add Packages** and search for **Lottie**.

### 5. Build and Run

Once everything is configured, you can build and run the app on a simulator or real device using Xcode.

---

## Usage

### Dog Size Selection

When the app is first launched, you’ll be prompted to select your dog's size:
- **Small**: Can walk safely in cooler temperatures (threshold: 25°C)
- **Medium**: Can walk safely in moderate temperatures (threshold: 30°C)
- **Large**: Can handle warmer temperatures (threshold: 35°C)

This size is stored, so you won't be asked to choose again unless you reset it.

### Weather Screen

Once your location is determined and the weather is fetched:
- The app shows the current temperature at the top.
- A **green tick** and an animation of a dog walking will be shown if the temperature is safe.
- A **red cross** and an animation of a dog resting with water will be shown if it’s too hot to walk your dog.

### Resetting the Dog Size

To reset the dog size:
- Tap the **Reset** button on the main screen.
- You will be taken back to the dog size selection screen.

---

## Weather API

The app utilizes **WeatherKit**, which requires an **Apple Developer Account** and configuration in your **App ID**.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contributions

Feel free to open issues or submit pull requests if you find bugs or want to contribute new features.
