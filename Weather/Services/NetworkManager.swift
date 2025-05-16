//
//  NetworkManager.swift
//  Weather
//
//  Created by Ilyas on 14.05.2025.
//

import Foundation
import Alamofire

protocol NetworkManagerProtocol {
  func getWeatherInfo(
    withLatitude latitude: Double,
    andLongitude longitude: Double,
    completion: @escaping(Result<WeatherInfo, AFError>) -> Void
  )
}

final class NetworkManager: NetworkManagerProtocol {
  
  func getWeatherInfo(
    withLatitude latitude: Double,
    andLongitude longitude: Double,
    completion: @escaping(Result<WeatherInfo, AFError>) -> Void
  ) {
    guard let url = URL(string: "http://api.weatherapi.com/v1/forecast.json?key=fa8b3df74d4042b9aa7135114252304&q=\(latitude),\(longitude)&days=7")
    else {
      completion(.failure(AFError.invalidURL(url: URL(string: "")!)))
      return
    }
    
    AF.request(url)
      .validate()
      .responseDecodable(of: WeatherInfo.self) { response in
        switch response.result {
        case .success(let weatherInfo):
          completion(.success(weatherInfo))
        case .failure(let error):
          completion(.failure(error))
          print(error)
        }
      }
  }
}
