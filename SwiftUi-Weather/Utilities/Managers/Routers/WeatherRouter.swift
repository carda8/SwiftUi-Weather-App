//
//  NetworkManagerTwo.swift
//  SwiftUi-Weather
//
//  Created by SeungJun Lee on 5/8/24.
//

import Alamofire
import Foundation

struct Coordinate: Codable {
    var latitude: Double
    var longitude: Double
}

enum WeatherRouter: URLRequestConvertible {
    
    // 1.
    case getCurrentWeather(coordinate: Coordinate)
    case getDailyForecast(coordinate: Coordinate)
    
    // 2.
    var path: String {
        switch self {
        case .getCurrentWeather:
            return "weather"
        case .getDailyForecast:
            return "forecast"
        }
    }
    
    // 3.
    var method: HTTPMethod {
        switch self {
        case .getCurrentWeather:
            return .get
        case .getDailyForecast:
            return .get
            
        }
    }
    
    // 4.
    var parameters: Parameters? {
        switch self {
        case .getCurrentWeather(let coordinate):
            return [
                "lat" : coordinate.latitude,
                "lon" : coordinate.longitude,
                "appid" : Constants.apiKey,
                "units" : "metric"
            ]
        case .getDailyForecast(let coordinate):
            return [
                "lat" : coordinate.latitude,
                "lon" : coordinate.longitude,
                "appid" : Constants.apiKey,
                "units" : "metric"
            ]
        default:
            return nil
        }
    }
    
    // 5.
    func asURLRequest() throws -> URLRequest {
       // 6.
        let url = try URL(string: Constants.baseURL.asURL()
                                                  .appendingPathComponent(path)
                                                  .absoluteString.removingPercentEncoding!)
        // 7.
        var request = URLRequest.init(url: url!)
        // 8.
        request.httpMethod = method.rawValue
        // 9.
        request.timeoutInterval = TimeInterval(10*1000)
        // 10.
        return try URLEncoding.default.encode(request,with: parameters)
    }
}
