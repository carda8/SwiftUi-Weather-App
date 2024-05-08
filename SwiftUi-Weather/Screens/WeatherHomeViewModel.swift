//
//  WeatherViewModel.swift
//  SwiftUi-Weather
//
//  Created by SeungJun Lee on 5/5/24.
//

import SwiftUI

final class WeatherHomeViewModel: ObservableObject {
    @Published var isNight = false
    @Published var isLoading = false
    @Published var currentWeatherInfo: WeatherAllInfo?
    
    func getCurrentWeather(
        lat: Double = Constants.baseLatitude,
        lon: Double = Constants.baseLongitude
    ) -> Void {
        isLoading = true
        
        NetworkManager.networkRequest.fetchCurrent(
            coordinate: Coordinate(
                latitude: lat,
                longitude: lon
            )
        ) { result in
            switch result {
            case .success(let data):
                self.currentWeatherInfo = data
                return
            case .failure(let error):
                return
            }
        }
    }
}
