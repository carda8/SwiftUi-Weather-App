//
//  NetworkManager.swift
//  SwiftUi-Weather
//
//  Created by SeungJun Lee on 5/5/24.
//

import Foundation
import Alamofire

final class NetworkManager {
    static let networkRequest = NetworkManager()
    
    private init () {}
    
//    func requestApi<X: Codable>(api: API<X>, path: String, returnType: WeatherAllInfo.Type, completion: @escaping (Result<WeatherAllInfo, AFError>) -> Void) {
//        let baseURL = "https://api.openweathermap.org/data/2.5/"
//        let apiKey = "4e0ccd50f20361f1f402412649abfce8"
//        let url = baseURL + path + "&appid=\(apiKey)&units=metric"
//        
//        AF.request(url, method: api.method)
//            .cacheResponse(using:.cache)
//            .validate(statusCode: 200 ..< 300)
//            .validate(contentType:["application/json"])
////            .responseJSON { result in
////                print(result)
////            }
//            .responseDecodable(of: WeatherAllInfo.self) { response in
//                print("response ::::: ")
//                switch response.result {
//                case.success(let data):
//                    completion(.success(data))
//                case.failure(let error):
//                    completion(.failure(error))
//                }
//            }
//    }
//    
//    func fetchCurrentWeather(api: API<CurrentWeatherParams>, completion: @escaping (Result<WeatherAllInfo, AFError>) -> Void) {
//        let path = "weather?lat=\(api.params.lat)&lon=\(api.params.lon)"
//        
//        requestApi(
//            api: api,
//            path: path,
//            returnType: WeatherAllInfo.self,
//            completion: completion
//        )
//    }
    
    func fetchCurrent(coordinate params: Coordinate, completion: @escaping (Result<WeatherAllInfo, AFError>) -> Void) -> Void {
        AF.request(WeatherRouter.getCurrentWeather(coordinate: params))
            .validate(statusCode: 200 ..< 300)
            .validate(contentType:["application/json"])
            .responseDecodable(of: WeatherAllInfo.self) { response in
                switch response.result {
                    case.success(let data):
                        print("DATA ::", data)
                        completion(.success(data))
                    case.failure(let error):
                        print("ERROR ::", error)
                        completion(.failure(error))
                }
            }
    }
    
    func fetchDailyForecast(coordinate params: Coordinate, completion: @escaping (Result<WeatherAllInfo, AFError>) -> Void) -> Void {
        AF.request(WeatherRouter.getDailyForecast(coordinate: params))
            .validate(statusCode: 200 ..< 300)
            .validate(contentType:["application/json"])
            .responseDecodable(of: WeatherAllInfo.self) { response in
                switch response.result {
                    case.success(let data):
                        print("DATA ::", data)
                        completion(.success(data))
                    case.failure(let error):
                        print("ERROR ::", error)
                        completion(.failure(error))
                }
            }
    }
}
