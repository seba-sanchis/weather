//
//  WeatherModel.swift
//  weather
//
//  Created by Sebastian Sanchis on 16/11/2023.
//

import Foundation

struct Location: Decodable {
    let country: String
}

struct Temperature: Decodable {
    let temp: Double
    let temp_min: Double
    let temp_max: Double
}

struct Weather: Decodable, Identifiable {
    let id: Int
    let main: String
    let description: String
}

struct WeatherResponse: Decodable {
    let sys: Location
    let name: String
    let main: Temperature
    let weather: [Weather]
}
