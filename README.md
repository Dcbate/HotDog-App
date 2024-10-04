# Dog Walking Weather App 🌤️🐕

This app tells you if it's safe to walk your dog based on the weather and temperature in your location. It uses the **OpenWeatherMap API** to fetch real-time weather data and provides a visual cue with animations of either a walking dog or a dog drinking water.

## Features
- 🌡️ Displays the current temperature.
- 🐕 Shows a walking dog animation if the weather is safe for walking.
- ☀️ Shows a "too hot" animation if the temperature is too high for safe walking.
- Uses **Core Location** to get the user's location.
- Retrieves weather data using the **OpenWeatherMap API**.

## Requirements
- iOS 14.0+
- Xcode 12.0+
- **Lottie** for animations.

## Installation
1. Clone this repository to your local machine:
    ```bash
    git clone https://github.com/your-username/my-ios-app.git
    ```

2. Open the project in **Xcode**.

3. Install any dependencies (such as **Lottie**) via **Swift Package Manager**:
    - Go to `File > Swift Packages > Add Package Dependency`.
    - Add the **Lottie** package: `https://github.com/airbnb/lottie-ios`.

4. Obtain an API key from **OpenWeatherMap**:
    - Sign up for a free account on [OpenWeatherMap](https://openweathermap.org/).
    - Go to **API keys** and generate a new key.

5. Add your API key to the project:
    - Open `ViewController.swift` and replace `YOUR_API_KEY` with your actual API key:
      ```swift
      let apiKey = "YOUR_API_KEY"
      ```

## Usage
Once you have the app installed, simply run it, allow location permissions, and the app will display the current weather and let you know if it’s safe to walk your dog.

- If the temperature is safe, you'll see a walking dog animation. 🐕
- If it's too hot, you'll see a dog drinking water, indicating it's too hot for a walk. 🌡️

## Screenshots
![Safe to Walk](https://your-image-link-here.png)
![Too Hot](https://your-image-link-here.png)

## License
This project is licensed under the MIT License.
