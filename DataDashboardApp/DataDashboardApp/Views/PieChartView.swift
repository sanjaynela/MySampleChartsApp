import SwiftUI
import Charts

struct PieChartView: View {
    @StateObject private var viewModel = WeatherViewModel()
    @State private var selectedCity: String?
    
    private let chartColors: [Color] = [
        .blue,
        .green,
        .orange,
        .purple,
        .red,
        .yellow
    ]
    
    private var cityColorMap: [String: Color] {
        Dictionary(uniqueKeysWithValues: CityCoordinates.cities.enumerated().map { index, city in
            (city.name, chartColors[index % chartColors.count])
        })
    }
    
    var body: some View {
        VStack {
            Text("Temperature Distribution")
                .font(.title)
                .padding()
            
            if viewModel.isLoading {
                loadingView
            } else if let error = viewModel.error {
                errorView(error)
            } else {
                chartContent
            }
        }
    }
    
    private var loadingView: some View {
        ProgressView()
            .onAppear {
                viewModel.fetchAllCitiesData()
            }
    }
    
    private func errorView(_ error: String) -> some View {
        Text(error)
            .foregroundColor(.red)
            .padding()
    }
    
    private var chartContent: some View {
        VStack {
            temperatureChart
            if let selected = selectedCity {
                selectedCityView(selected)
            }
            legendView
        }
    }
    
    private var temperatureChart: some View {
        Chart {
            ForEach(CityCoordinates.cities, id: \.name) { city in
                if let avgTemp = viewModel.getAverageTemperature(for: city.name) {
                    SectorMark(
                        angle: .value("Temperature", avgTemp),
                        innerRadius: .ratio(0.618),
                        angularInset: 1.5
                    )
                    .foregroundStyle(by: .value("City", city.name))
                    .annotation(position: .overlay) {
                        Text("\(String(format: "%.1f°C", avgTemp))")
                            .font(.caption)
                            .foregroundColor(.white)
                    }
                }
            }
        }
        .frame(height: 300)
        .padding()
    }
    
    private func selectedCityView(_ city: String) -> some View {
        Group {
            if let avgTemp = viewModel.getAverageTemperature(for: city) {
                VStack {
                    Text(city)
                        .font(.headline)
                    Text("Average: \(String(format: "%.1f°C", avgTemp))")
                        .font(.title2)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(8)
                .shadow(radius: 2)
            }
        }
    }
    
    private var legendView: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 10) {
            ForEach(CityCoordinates.cities, id: \.name) { city in
                if let avgTemp = viewModel.getAverageTemperature(for: city.name) {
                    legendItem(city: city, avgTemp: avgTemp)
                }
            }
        }
        .padding()
    }
    
    private func legendItem(city: CityCoordinates, avgTemp: Double) -> some View {
        HStack {
            Circle()
                .fill(cityColorMap[city.name] ?? .gray)
                .frame(width: 10, height: 10)
            Text(city.name)
            Text("\(String(format: "%.1f°C", avgTemp))")
                .foregroundColor(.secondary)
        }
    }
}

struct PieChartView_Previews: PreviewProvider {
    static var previews: some View {
        PieChartView()
    }
}