//
//  WeatherAPI.swift
//  weather
//
//  Created by Sebastian Sanchis on 16/11/2023.
//

import Foundation

final class APIService {
    
    static let shared = APIService()
    
    private let baseURL = "https://api.openweathermap.org/data/2.5/weather"
    private let apiKey = "448311464ac4abababa5eaef0179d8cc"
    
    private var currentWeatherURL: URL? {
        var components = URLComponents(string: baseURL)
        components?.queryItems = [
            URLQueryItem(name: "q", value: "Buenos Aires,ar"),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "appid", value: apiKey)
        ]
        return components?.url
    }
    
    private init() {}
    
    func getWeather() async throws -> WeatherResponse {
        guard let url = currentWeatherURL else {
            throw ErrorService.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
            throw ErrorService.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(WeatherResponse.self, from: data)
        } catch {
            throw ErrorService.invalidData
        }
    }
}
