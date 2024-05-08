//
//  Weather.swift
//  SwiftUi-Weather
//
//  Created by SeungJun Lee on 5/5/24.
//

import Foundation

struct WeatherStatus: Codable {
    let id: Int
    let main, description, icon: String
}

struct WeatherAllInfo: Codable {
    let coord: Coord
    let weather: [WeatherStatus]
    let base: String?
    let main: Main?
    let visibility: Int?
    let wind: Wind?
    let rain: Rain?
    let clouds: Clouds?
    let dt: Int?
    let sys: Sys?
    let timezone, id: Int?
    let name: String?
    let cod: Int?
}

struct Clouds: Codable {
    let all: Int
}

struct Coord: Codable {
    let lon, lat: Double
}

struct Main: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
}

struct Rain: Codable {
    let the1H: Double

    enum CodingKeys: String, CodingKey {
        case the1H = "1h"
    }
}

struct Sys: Codable {
    let type, id: Int?
    let country: String?
    let sunrise, sunset: Int?
}


struct Wind: Codable {
    let speed: Double?
    let deg: Int?
    let gust: Double?
}

