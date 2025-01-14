# Weather Application

## Overview
This is a Weather Application that provides real-time weather updates based on your current location or any specified location. The app is built using Flutter and leverages the following technologies and APIs:

- **GeoLocator**: To access the user’s current location.
- **GeoCoding**: To convert geographic coordinates into human-readable addresses and vice versa.
- **OpenWeather API**: To fetch weather data.
- **Provider**: For state management within the application.

---

## Features
- Displays real-time weather information for the user's current location.
- Search functionality to get weather data for any city.
- Interactive UI with weather icons and detailed weather data (temperature, humidity, wind speed, etc.).
- Error handling for location services and API requests.

---

## Technologies Used
### 1. **Flutter**
- A framework for building natively compiled applications for mobile, web, and desktop from a single codebase.

### 2. **GeoLocator**
- Used to fetch the device's GPS coordinates.
- Handles location permissions and access.

### 3. **GeoCoding**
- Converts coordinates into addresses and addresses into coordinates.

### 4. **OpenWeather API**
- Fetches real-time weather data including temperature, weather condition, wind speed, etc.
- [OpenWeather API Documentation](https://openweathermap.org/api)

### 5. **Provider**
- Manages state across the application efficiently.

---

## Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/shibilishiyad/weather_app.git
   ```

2. Navigate to the project directory:
   ```bash
   cd weather_app
   ```

3. Install dependencies:
   ```bash
   flutter pub get
   ```

4. Set up the OpenWeather API key:
   - Create a `.env` file in the root directory.
   - Add your OpenWeather API key:
     ```env
     API_KEY=your_openweather_api_key
     ```

5. Run the application:
   ```bash
   flutter run
   ```

---

## Usage
1. Open the app.
2. Grant location permissions when prompted.
3. View real-time weather data for your current location.
4. Use the search bar to get weather updates for other locations.

---

## Screenshots
(Add relevant screenshots of your app here.)

---

## Project Structure
```
weather_app/
├── lib/
│   ├── main.dart          # Entry point of the application
│   ├── models/            # Data models (e.g., WeatherModel)
│   ├── providers/         # State management logic
│   ├── screens/           # UI screens (e.g., HomeScreen, SearchScreen)
│   └── services/          # API and location service integration
├── assets/                # App assets (e.g., icons, images)
├── pubspec.yaml           # Dependencies and app metadata
└── .env                   # API key configuration (not committed to Git)
```

---

## Dependencies
Here are the main dependencies used in this project:
- `provider`: State management
- `geolocator`: Fetches the user's location
- `geocoding`: Converts coordinates to human-readable addresses
- `http`: Makes API requests

Add these to your `pubspec.yaml`:
```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.0.5
  geolocator: ^9.0.2
  geocoding: ^3.0.1
  http: ^0.15.0
```

---

## Contributing
Contributions are welcome! Follow these steps:
1. Fork the repository.
2. Create a new branch:
   ```bash
   git checkout -b feature-branch-name
   ```
3. Commit your changes:
   ```bash
   git commit -m "Add a descriptive message"
   ```
4. Push to the branch:
   ```bash
   git push origin feature-branch-name
   ```
5. Open a pull request.

---

## License
This project is licensed under the [MIT License](LICENSE).

---

## Contact
- **Author**: Shibili Shiyad
- **GitHub**: [shibilishiyad](https://github.com/shibilishiyad)
- **LinkedIn**: [Shibili Shiyad](https://www.linkedin.com/in/shibilishiyad/)
