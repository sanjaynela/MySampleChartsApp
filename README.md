# Data Dashboard iOS App

This iOS app demonstrates how to create beautiful data visualizations using SwiftUI Charts. The app fetches real-world temperature data from the Open-Meteo API, parses it, and visualizes it using interactive charts.

## Features
- Fetches live daily temperature data from the Open-Meteo API
- Line charts for temperature trends by city
- Bar charts for city temperature comparison
- Pie charts for average temperature distribution
- Interactive data visualization with tooltips and details
- Loading and error handling states
- Dark mode support

## Requirements
- iOS 16.0+
- Xcode 14.0+
- Swift 5.7+

## Setup
1. Clone the repository
2. Open `DataDashboardApp.xcodeproj` in Xcode
3. Build and run the project

## Project Structure
- `DataDashboardApp.swift`: Main app entry point
- `ContentView.swift`: Tab-based dashboard
- `Models/ChartData.swift`: Data models and API response parsing
- `ViewModels/WeatherViewModel.swift`: Handles API calls and state
- `Views/`: Contains all SwiftUI chart views

## How it Works
- The app uses a `WeatherViewModel` to fetch temperature data for multiple cities (e.g., New York, London) from the Open-Meteo API.
- Data is parsed into Swift models and displayed in interactive charts using SwiftUI Charts.
- Users can select cities, view trends, compare temperatures, and see average distributions in real time.

## API Reference
- [Open-Meteo API](https://open-meteo.com/)

## Credits
- Inspired by the Medium article: [How to Build a Beautiful Data Dashboard App on iOS Using SwiftUI Charts](https://medium.com/@sanjaynelagadde1992/how-to-build-a-beautiful-data-dashboard-app-on-ios-using-swiftui-charts-1019a362fa5c) 