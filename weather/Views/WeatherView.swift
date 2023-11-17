//
//  WeatherView.swift
//  weather
//
//  Created by Sebastian Sanchis on 15/11/2023.
//

import SwiftUI

struct WeatherView: View {
    
    @StateObject var viewModel = WeatherViewModel()
    
    var body: some View {
        ZStack {
            ContainerRelativeShape()
                .fill(viewModel.backgroundColor())
                .ignoresSafeArea()
            
            VStack (spacing: 32) {
                Text("\(viewModel.city ?? ""), \(viewModel.country?.country ?? "")")
                    .font(.system(size: 32, weight: .semibold))
                    .foregroundColor(.white)
                
                VStack {
                    Image(systemName: WeatherIcon(rawValue: viewModel.weather.first?.main ?? "").rawValue)
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 192, height: 192)
                    
                    Text(String(format: "%.2f°", viewModel.temperature?.temp ?? 0))
                        .font(.system(size: 56))
                        .foregroundColor(.white)
                    
                    Text("\(viewModel.weather.first?.description.capitalized ?? "")")
                        .font(.system(size: 32))
                        .foregroundColor(.white)
                    
                    HStack {
                        Text("H: \(String(format: "%.2f", viewModel.temperature?.temp_max ?? 0))°")
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                        
                        Text("L: \(String(format: "%.2f", viewModel.temperature?.temp_min ?? 0))°")
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                    }
                }
                .padding(.bottom)
                
                HStack (spacing: 16) {
                    WeatherDayView(dayOfWeek: "Mon", imageName: "cloud.sun.fill", temperature: 25)
                    
                    WeatherDayView(dayOfWeek: "Tue", imageName: "cloud.fill", temperature: 23)
                    
                    WeatherDayView(dayOfWeek: "Wed", imageName: "cloud.sun.rain.fill", temperature: 19)
                    
                    WeatherDayView(dayOfWeek: "Thu", imageName: "wind", temperature: 21)
                    
                    WeatherDayView(dayOfWeek: "Fri", imageName: "sun.max.fill", temperature: 27)
                }
                .padding()
                .background(Color.black.opacity(0.1))
                .cornerRadius(8)
            }
        }
        .task {
            viewModel.getWeather()
        }
    }
}

#Preview {
    WeatherView()
}

enum WeatherIcon: String {
    case clear = "sun.max.fill"
    case clouds = "cloud.fill"
    case drizzle = "cloud.drizzle.fill"
    case rain = "cloud.rain.fill"
    case snow = "snowflake"
    case thunderstorm = "cloud.bolt.rain.fill"
    case unknown = "questionmark"

    init(rawValue: String) {
        switch rawValue {
        case "Clear":
            self = .clear
        case "Clouds":
            self = .clouds
        case "Drizzle":
            self = .drizzle
        case "Rain":
            self = .rain
        case "Snow":
            self = .snow
        case "Thunderstorm":
            self = .thunderstorm
        default:
            self = .unknown
        }
    }
}

struct WeatherDayView: View {
    
    var dayOfWeek: String
    var imageName: String
    var temperature: Int
    
    var body: some View {
        VStack {
            Text(dayOfWeek)
                .font(.system(size: 16))
                .foregroundColor(.white)
            
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 48, height: 48)
            
            Text("\(temperature)°")
                .font(.system(size: 24))
                .foregroundColor(.white)
        }
    }
}
