//
//  WeatherViewModel.swift
//  weather
//
//  Created by Sebastian Sanchis on 16/11/2023.
//

import SwiftUI

final class WeatherViewModel: ObservableObject {
    
    @Published var city: String?
    @Published var country: Location?
    @Published var temperature: Temperature?
    @Published var weather: [Weather] = []
    
    @Published var isLoading = false
    
    @MainActor
    func getWeather() {
        isLoading = true
        
        Task {
            do {
                let response = try await APIService.shared.getWeather()
                
                // Perform UI updates directly (no need for additional Task) because of @MainActor
                self.city = response.name
                self.country = response.sys
                self.temperature = response.main
                self.weather = response.weather
                
                self.isLoading = false
            } catch {
                // Perform UI updates directly (no need for additional Task) because of @MainActor
                print("API Error Code: \(error as? ErrorService)")
                self.isLoading = false
            }
        }
    }
    
    func backgroundColor() -> AnyGradient {
            guard let weatherMain = self.weather.first?.main else {
                return Color.blue.gradient // Default color
            }

            switch WeatherIcon(rawValue: weatherMain) {
            case .clear, .clouds, .drizzle:
                return Color.blue.gradient
            case .rain, .snow, .thunderstorm:
                return Color.gray.gradient
            default:
                return Color.blue.gradient // Default color
            }
        }
}

