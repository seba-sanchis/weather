//
//  WeatherView.swift
//  weather
//
//  Created by Sebastian Sanchis on 15/11/2023.
//

import SwiftUI

struct WeatherView: View {
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
                    Image(systemName: "cloud.sun.fill")
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 192)
                    
                    Text("72°")
                        .font(.system(size: 56))
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
    }
}

#Preview {
    WeatherView()
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
