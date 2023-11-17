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
                .fill(Color.blue.gradient)
                .ignoresSafeArea()
            
            VStack (spacing: 48) {
                Text("San Francisco, CA")
                    .font(.system(size: 32, weight: .semibold))
                    .foregroundColor(.white)
                    .padding()
                
                VStack {
                    Image(systemName: WeatherIcon(rawValue: viewModel.weather.first?.main ?? "").rawValue)
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 192)
                    
                    Text("\(viewModel.temperature?.temp ?? 0)°")
                        .font(.system(size: 56))
                        .foregroundColor(.white)
                    
                    Text("\(viewModel.weather.first?.description ?? "")")
                        .font(.system(size: 32))
                        .foregroundColor(.white)
                    
                }
                
                HStack (spacing: 16) {
                    WeatherDayView(dayOfWeek: "Mon", imageName: "cloud.sun.fill", temperature: 72)
                    
                    WeatherDayView(dayOfWeek: "Tue", imageName: "cloud.fill", temperature: 64)
                    
                    WeatherDayView(dayOfWeek: "Wed", imageName: "cloud.sun.rain.fill", temperature: 48)
                    
                    WeatherDayView(dayOfWeek: "Thu", imageName: "wind", temperature: 56)
                    
                    WeatherDayView(dayOfWeek: "Fri", imageName: "sun.max.fill", temperature: 80)
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
    case rain = "cloud.rain.fill"
    case clouds = "cloud.fill"
    case unknown = "questionmark.circle.fill"

    init(rawValue: String) {
        switch rawValue {
        case "Clouds":
            self = .clouds
        case "Rain":
            self = .rain
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
