//
//  NetworkManager.swift
//  Weather
//
//  Created by Ilyas on 14.05.2025.
//

import Foundation
import Alamofire

final class NetworkManager {
  
  static let shared = NetworkManager()
  
  private init() {}
  
  func getWeatherInfo(withCity city: String, completion: @escaping(Result<WeatherInfo, AFError>) -> Void) {
    guard let url = URL(string: "http://api.weatherapi.com/v1/forecast.json?key=fa8b3df74d4042b9aa7135114252304&q=\(city)&days=7")
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
