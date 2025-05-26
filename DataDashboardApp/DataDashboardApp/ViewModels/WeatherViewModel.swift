import Foundation
import Combine

class WeatherViewModel: ObservableObject {
    @Published var cityTemperatures: [String: [DailyTemperature]] = [:]
    @Published var isLoading = false
    @Published var error: String?
    
    func fetchWeatherData(for city: CityCoordinates) {
        isLoading = true
        error = nil
        
        let urlString = "https://api.open-meteo.com/v1/forecast?latitude=\(city.latitude)&longitude=\(city.longitude)&daily=temperature_2m_max&timezone=\(city.timezone.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
        
        guard let url = URL(string: urlString) else {
            error = "Invalid URL"
            isLoading = false
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                if let error = error {
                    self?.error = error.localizedDescription
                    return
                }
                
                guard let data = data else {
                    self?.error = "No data received"
                    return
                }
                
                do {
                    let decoded = try JSONDecoder().decode(WeatherResponse.self, from: data)
                    self?.cityTemperatures[city.name] = decoded.toDailyTemperatures()
                } catch {
                    self?.error = "Failed to decode data: \(error.localizedDescription)"
                }
            }
        }.resume()
    }
    
    func fetchAllCitiesData() {
        for city in CityCoordinates.cities {
            fetchWeatherData(for: city)
        }
    }
    
    func getAverageTemperature(for city: String) -> Double? {
        guard let temperatures = cityTemperatures[city] else { return nil }
        return temperatures.map { $0.temperature }.reduce(0, +) / Double(temperatures.count)
    }
} 