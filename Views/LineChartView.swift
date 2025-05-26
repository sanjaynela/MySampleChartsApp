import SwiftUI
import Charts

struct LineChartView: View {
    @State private var selectedDataPoint: TemperatureData?
    @State private var selectedCity: String = TemperatureData.cities[0]
    
    var body: some View {
        VStack {
            Text("Temperature Trends")
                .font(.title)
                .padding()
            
            Picker("Select City", selection: $selectedCity) {
                ForEach(TemperatureData.cities, id: \.self) { city in
                    Text(city).tag(city)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
            
            Chart {
                ForEach(TemperatureData.getDataForCity(selectedCity)) { point in
                    LineMark(
                        x: .value("Date", point.date),
                        y: .value("Temperature", point.temperature)
                    )
                    .foregroundStyle(Color.blue.gradient)
                    
                    PointMark(
                        x: .value("Date", point.date),
                        y: .value("Temperature", point.temperature)
                    )
                    .foregroundStyle(Color.blue)
                }
                
                if let selected = selectedDataPoint {
                    RuleMark(
                        x: .value("Selected", selected.date)
                    )
                    .foregroundStyle(Color.gray.opacity(0.3))
                    .annotation(position: .top) {
                        VStack {
                            Text(selected.date, style: .date)
                            Text("\(String(format: "%.1f°C", selected.temperature))")
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                        .shadow(radius: 2)
                    }
                }
            }
            .chartXAxis {
                AxisMarks(values: .stride(by: .day)) { value in
                    AxisGridLine()
                    AxisValueLabel(format: .dateTime.weekday())
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
                                    guard let date = proxy.value(atX: x) as Date? else { return }
                                    
                                    // Find the closest data point
                                    selectedDataPoint = TemperatureData.getDataForCity(selectedCity).min(by: {
                                        abs($0.date.timeIntervalSince(date)) < abs($1.date.timeIntervalSince(date))
                                    })
                                }
                                .onEnded { _ in
                                    selectedDataPoint = nil
                                }
                        )
                }
            }
        }
    }
}

struct LineChartView_Previews: PreviewProvider {
    static var previews: some View {
        LineChartView()
    }
} 