import SwiftUI
import Charts

struct PieChartView: View {
    @StateObject private var viewModel = WeatherViewModel()
    @State private var selectedCity: String?
    
    var body: some View {
        VStack {
            Text("Temperature Distribution")
                .font(.title)
                .padding()
            
            if viewModel.isLoading {
                ProgressView()
                    .onAppear {
                        viewModel.fetchAllCitiesData()
                    }
            } else if let error = viewModel.error {
                Text(error)
                    .foregroundColor(.red)
                    .padding()
            } else {
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
                
                if let selected = selectedCity,
                   let avgTemp = viewModel.getAverageTemperature(for: selected) {
                    VStack {
                        Text(selected)
                            .font(.headline)
                        Text("Average: \(String(format: "%.1f°C", avgTemp))")
                            .font(.title2)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(radius: 2)
                }
                
                // Legend
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 10) {
                    ForEach(CityCoordinates.cities, id: \.name) { city in
                        if let avgTemp = viewModel.getAverageTemperature(for: city.name) {
                            HStack {
                                Circle()
                                    .fill(Color(hue: Double(CityCoordinates.cities.firstIndex(where: { $0.name == city.name }) ?? 0) / Double(CityCoordinates.cities.count)))
                                    .frame(width: 10, height: 10)
                                Text(city.name)
                                Text("\(String(format: "%.1f°C", avgTemp))")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
                .padding()
            }
        }
    }
}

struct PieChartView_Previews: PreviewProvider {
    static var previews: some View {
        PieChartView()
    }
} 