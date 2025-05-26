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

## Setup and Running Instructions

### 1. Create a New Xcode Project
1. Open Xcode
2. Click "Create a new Xcode project"
3. Choose "App" under iOS
4. Click "Next"
5. Fill in the project details:
   - Product Name: "DataDashboardApp"
   - Interface: "SwiftUI"
   - Language: "Swift"
   - Minimum Deployment: "iOS 16.0"
6. Click "Next" and choose a location to save your project

### 2. Add Project Files
Create the following directory structure and add the files:

```
DataDashboardApp/
├── DataDashboardApp.swift
├── ContentView.swift
├── Models/
│   └── ChartData.swift
├── ViewModels/
│   └── WeatherViewModel.swift
└── Views/
    ├── LineChartView.swift
    ├── BarChartView.swift
    └── PieChartView.swift
```

### 3. Configure Project Settings
1. In Xcode, select your project in the navigator
2. Select your target
3. Under "Signing & Capabilities":
   - Select your development team
   - Update the Bundle Identifier if needed

### 4. Run the App
1. Select a simulator (e.g., iPhone 14 Pro) from the device menu in the toolbar
2. Click the "Play" button (▶️) or press Cmd + R to build and run
3. The app will launch in the simulator and automatically fetch temperature data

### Troubleshooting
- If you see build errors, ensure all files are in the correct directories
- Check that the deployment target is set to iOS 16.0 or later
- Verify your internet connection for API calls
- If the charts don't appear, check the console for any API errors

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