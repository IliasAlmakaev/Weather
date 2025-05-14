//
//  WeatherInfo.swift
//  Weather
//
//  Created by Ilyas on 14.05.2025.
//

import Foundation

struct WeatherInfo: Decodable {
  let currentTimeEpoch: Int
  let days: [Day]
  
  enum CodingKeys: String, CodingKey {
    case current, forecast
  }
  
  enum CurrentKeys: String, CodingKey {
    case currentTimeEpoch = "last_updated_epoch"
  }
  
  enum ForecastKeys: String, CodingKey {
    case days = "forecastday"
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let current = try container.nestedContainer(keyedBy: CurrentKeys.self, forKey: .current)
    let forecast = try container.nestedContainer(keyedBy: ForecastKeys.self, forKey: .forecast)
    
    currentTimeEpoch = try current.decode(Int.self, forKey: .currentTimeEpoch)
    days = try forecast.decode([Day].self, forKey: .days)
  }
}

struct Day: Decodable {
  let timeEpoch: Int
  let minTemperature: Double
  let maxTemperature: Double
  let iconUrl: String
  let hours: [Hour]
  
  enum CodingKeys: String, CodingKey {
    case timeEpoch = "date_epoch"
    case day, hour
  }
  
  enum DayKeys: String, CodingKey {
    case minTemperature = "mintemp_c"
    case maxTemperature = "maxtemp_c"
    case condition
  }
  
  enum ConditionKeys: String, CodingKey {
    case icon
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let day = try container.nestedContainer(keyedBy: DayKeys.self, forKey: .day)
    let condition = try day.nestedContainer(keyedBy: ConditionKeys.self, forKey: .condition)
    
    timeEpoch = try container.decode(Int.self, forKey: .timeEpoch)
    minTemperature = try day.decode(Double.self, forKey: .minTemperature)
    maxTemperature = try day.decode(Double.self, forKey: .maxTemperature)
    iconUrl = try condition.decode(String.self, forKey: .icon)
    hours = try container.decode([Hour].self, forKey: .hour)
  }
}

struct Hour: Decodable {
  let timeEpoch: Int
  let temperature: Double
  let iconUrl: String
  
  enum CodingKeys: String, CodingKey {
    case timeEpoch = "time_epoch"
    case temperature = "temp_c"
    case condition
  }
  
  enum ConditionKeys: String, CodingKey {
    case icon
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let condition = try container.nestedContainer(keyedBy: ConditionKeys.self, forKey: .condition)
    
    timeEpoch = try container.decode(Int.self, forKey: .timeEpoch)
    temperature = try container.decode(Double.self, forKey: .temperature)
    iconUrl = try condition.decode(String.self, forKey: .icon)
  }
}
