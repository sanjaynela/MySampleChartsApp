import SwiftUI
import Charts

struct BarChartView: View {
    @StateObject private var viewModel = WeatherViewModel()
    @State private var selectedCity: String?
    
    var body: some View {
        VStack {
            Text("City Temperature Comparison")
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
                        if let temperatures = viewModel.cityTemperatures[city.name],
                           let latestTemp = temperatures.last?.temperature {
                            BarMark(
                                x: .value("City", city.name),
                                y: .value("Temperature", latestTemp)
                            )
                            .foregroundStyle(Color.green.gradient)
                            .annotation(position: .top) {
                                Text("\(String(format: "%.1f°C", latestTemp))")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    
                    if let selected = selectedCity,
                       let temperatures = viewModel.cityTemperatures[selected],
                       let latestTemp = temperatures.last?.temperature {
                        RuleMark(
                            y: .value("Selected", latestTemp)
                        )
                        .foregroundStyle(Color.gray.opacity(0.3))
                        .annotation(position: .trailing) {
                            Text("\(String(format: "%.1f°C", latestTemp))")
                                .padding()
                                .background(Color.white)
                                .cornerRadius(8)
                                .shadow(radius: 2)
                        }
                    }
                }
                .chartYAxis {
                    AxisMarks(position: .leading) { value in
                        AxisGridLine()
                        AxisValueLabel {
                            if let temp = value.as(Double.self) {
                                Text("\(String(format: "%.1f°C", temp))")
                            }
                        }
                    }
                }
                .frame(height: 300)
                .padding()
                .chartOverlay { proxy in
                    GeometryReader { geometry in
                        Rectangle()
                            .fill(Color.clear)
                            .contentShape(Rectangle())
                            .gesture(
                                DragGesture()
                                    .onChanged { value in
                                        let x = value.location.x - geometry[proxy.plotAreaFrame].origin.x
                                        guard let city = proxy.value(atX: x) as String? else { return }
                                        selectedCity = city
                                    }
                                    .onEnded { _ in
                                        selectedCity = nil
                                    }
                            )
                    }
                }
                
                if let selected = selectedCity,
                   let temperatures = viewModel.cityTemperatures[selected] {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Temperature Details for \(selected)")
                            .font(.headline)
                        ForEach(temperatures.suffix(3)) { data in
                            HStack {
                                Text(data.date, style: .date)
                                Spacer()
                                Text("\(String(format: "%.1f°C", data.temperature))")
                            }
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(radius: 2)
                    .padding()
                }
            }
        }
    }
}

struct BarChartView_Previews: PreviewProvider {
    static var previews: some View {
        BarChartView()
    }
} 