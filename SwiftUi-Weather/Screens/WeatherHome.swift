//
//  ContentView.swift
//  SwiftUi-Weather
//
//  Created by SeungJun Lee on 3/22/24.
//

import SwiftUI
import Kingfisher
import CoreLocation

struct WeatherHome: View {
    @StateObject var viewModel = LocationManager()
    
    var body: some View {
        ZStack {
            BackgroundView(isNight: viewModel.isNight)
            
            VStack
            {
                ZStack {
                    VStack {
                        CityTextView(cityName: viewModel.currentWeatherInfo?.name ?? "Cupertino, CA")
                       
                        MainWeatherStatusView(imageName: viewModel.isNight ? "moon.stars.fill" : "cloud.sun.fill", iconId: viewModel.currentWeatherInfo?.weather.first?.icon
                                              , temperature: Int( viewModel.currentWeatherInfo?.main?.temp ?? 0), description: viewModel.currentWeatherInfo?.weather.first?.description ?? "")
                    }
                    .opacity(viewModel.isLoading ? 0:1)
                    
                    if viewModel.isLoading {
                        ProgressView("Loading...")
                            .progressViewStyle(CircularProgressViewStyle(tint: .lightBlue))
                            .scaleEffect(2)
                    }
                }

               
                HStack(spacing: 20) {
                    Weather(dayOfWeek: "TUE", imageName: "cloud.sun.fill", temperature: 10)
                    Weather(dayOfWeek: "WED", imageName: "sun.max.fill", temperature: 15)
                    Weather(dayOfWeek: "THU", imageName: "wind.snow", temperature: 0)
                    Weather(dayOfWeek: "FRI", imageName: "snowflake", temperature: -2)
                    Weather(dayOfWeek: "SAT", imageName: "smoke.fill", temperature: 07)
                }
                
                Spacer()
                
                Button {
//                    viewModel.requestLocation()
                    viewModel.isNight.toggle()
                } label: {
                    WeatherButton(title: "Change Day Time", textColor: .white, backgroundColor: .mint)
                }
                
                Spacer()
            }
        }
    }
}

#Preview {
    WeatherHome()
}

struct Weather: View {
    
    var dayOfWeek: String
    var imageName: String
    var temperature: Int
    
    var body: some View {
        VStack{
            Text(dayOfWeek).font(.system(size: 16, weight: .medium))
                .foregroundStyle(.white)
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
            Text("\(temperature)°")
                .font(.system(size: 28, weight: .medium))
                .foregroundStyle(.white)
        }
    }
}

struct BackgroundView: View {
    
    var isNight: Bool
    
    var body: some View {
        LinearGradient(gradient: Gradient(
            colors: [isNight ? .black : .blue, isNight ? .gray : .lightBlue]),
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
//        ContainerRelativeShape()
//            .fill(isNight ? Color.black.gradient : Color.blue.gradient)
//            .
//            .ignoresSafeArea()
    }
}

struct CityTextView: View{
    
    var cityName: String
    
    var body: some View{
        Text(cityName).font(.system(size: 32,weight: .medium, design: .default))
            .foregroundStyle(.white)
            .padding()
    }
}

struct MainWeatherStatusView: View {
    
    var imageName: String
    var iconId: String?
    var temperature: Int
    var description: String?

    var body: some View {
        VStack(spacing: 10){
            if iconId != nil {
                KFImage(URL(string: "https://openweathermap.org/img/wn/\(iconId!)@4x.png" ))
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 180, height: 180)
            } else {
                Image(systemName: imageName)
                    .symbolRenderingMode(.palette)
                    .resizable()
                    .foregroundStyle(.mint, .gray)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 180, height: 180)
            }
            Text(description ?? "").font(.title).fontWeight(.semibold)
            
            Text("\(temperature)°")
                .font(.system(size: 70, weight: .medium))
                .foregroundStyle(.white)
        }.padding(.bottom, 40)
    }
}
