import Foundation

struct DataPoint: Identifiable {
    let id = UUID()
    let date: Date
    let value: Double
}

struct CategoryData: Identifiable {
    let id = UUID()
    let category: String
    let value: Double
}

struct TemperatureData: Identifiable {
    let id = UUID()
    let city: String
    let temperature: Double
    let date: Date
}

struct DailyTemperature: Identifiable, Decodable {
    let id = UUID()
    let date: Date
    let temperature: Double
    
    enum CodingKeys: String, CodingKey {
        case date = "time"
        case temperature = "temperature_2m_max"
    }
}

struct WeatherResponse: Decodable {
    let daily: DailyData
    
    struct DailyData: Decodable {
        let time: [String]
        let temperature_2m_max: [Double]
    }
    
    func toDailyTemperatures() -> [DailyTemperature] {
        var result: [DailyTemperature] = []
        let dateFormatter = ISO8601DateFormatter()
        for (index, dateString) in daily.time.enumerated() {
            if let date = dateFormatter.date(from: dateString) {
                result.append(DailyTemperature(date: date, temperature: daily.temperature_2m_max[index]))
            }
        }
        return result
    }
}

// City coordinates for Open-Meteo API
struct CityCoordinates {
    let name: String
    let latitude: Double
    let longitude: Double
    let timezone: String
    
    static let cities: [CityCoordinates] = [
        CityCoordinates(name: "New York", latitude: 40.7128, longitude: -74.0060, timezone: "America/New_York"),
        CityCoordinates(name: "London", latitude: 51.5074, longitude: -0.1278, timezone: "Europe/London")
    ]
}

// Sample data
extension DataPoint {
    static let sampleData: [DataPoint] = [
        DataPoint(date: Calendar.current.date(byAdding: .day, value: -6, to: Date())!, value: 10),
        DataPoint(date: Calendar.current.date(byAdding: .day, value: -5, to: Date())!, value: 15),
        DataPoint(date: Calendar.current.date(byAdding: .day, value: -4, to: Date())!, value: 12),
        DataPoint(date: Calendar.current.date(byAdding: .day, value: -3, to: Date())!, value: 18),
        DataPoint(date: Calendar.current.date(byAdding: .day, value: -2, to: Date())!, value: 20),
        DataPoint(date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!, value: 16),
        DataPoint(date: Date(), value: 22)
    ]
}

extension CategoryData {
    static let sampleData: [CategoryData] = [
        CategoryData(category: "Category A", value: 30),
        CategoryData(category: "Category B", value: 45),
        CategoryData(category: "Category C", value: 25),
        CategoryData(category: "Category D", value: 60)
    ]
}

// Sample temperature data
extension TemperatureData {
    static let sampleData: [TemperatureData] = [
        TemperatureData(city: "New York", temperature: 22.5, date: Calendar.current.date(byAdding: .day, value: -6, to: Date())!),
        TemperatureData(city: "New York", temperature: 24.0, date: Calendar.current.date(byAdding: .day, value: -5, to: Date())!),
        TemperatureData(city: "New York", temperature: 23.2, date: Calendar.current.date(byAdding: .day, value: -4, to: Date())!),
        TemperatureData(city: "New York", temperature: 25.5, date: Calendar.current.date(byAdding: .day, value: -3, to: Date())!),
        TemperatureData(city: "New York", temperature: 26.0, date: Calendar.current.date(byAdding: .day, value: -2, to: Date())!),
        TemperatureData(city: "New York", temperature: 24.8, date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!),
        TemperatureData(city: "New York", temperature: 25.2, date: Date()),
        
        TemperatureData(city: "London", temperature: 18.5, date: Calendar.current.date(byAdding: .day, value: -6, to: Date())!),
        TemperatureData(city: "London", temperature: 19.0, date: Calendar.current.date(byAdding: .day, value: -5, to: Date())!),
        TemperatureData(city: "London", temperature: 18.8, date: Calendar.current.date(byAdding: .day, value: -4, to: Date())!),
        TemperatureData(city: "London", temperature: 20.5, date: Calendar.current.date(byAdding: .day, value: -3, to: Date())!),
        TemperatureData(city: "London", temperature: 21.0, date: Calendar.current.date(byAdding: .day, value: -2, to: Date())!),
        TemperatureData(city: "London", temperature: 20.8, date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!),
        TemperatureData(city: "London", temperature: 21.2, date: Date())
    ]
    
    static func getDataForCity(_ city: String) -> [TemperatureData] {
        return sampleData.filter { $0.city == city }
    }
    
    static let cities = ["New York", "London"]
} 