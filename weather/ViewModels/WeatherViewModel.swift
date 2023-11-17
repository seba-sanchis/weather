//
//  WeatherViewModel.swift
//  weather
//
//  Created by Sebastian Sanchis on 16/11/2023.
//

import SwiftUI

final class WeatherViewModel: ObservableObject {
    
    @Published var weather: [Weather] = []
    @Published var temperature: Temperature?
    @Published var isLoading = false
    
    @MainActor
    func getWeather() {
        isLoading = true
        
        Task {
            do {
                let response = try await APIService.shared.getWeather()
                
                // Perform UI updates directly (no need for additional Task) because of @MainActor
                self.weather = response.weather
                self.temperature = response.main
                self.isLoading = false
            } catch {
                // Perform UI updates directly (no need for additional Task) because of @MainActor
                print("API Error Code: \(error as? ErrorService)")
                self.isLoading = false
            }
        }
    }
}

