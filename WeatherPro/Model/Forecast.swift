//
//  Forecast.swift
//  WeatherPro
//
//  Created by 윤준영 on 2023/07/03.
//

import Foundation

struct Forecast: Codable {
    let cod: String
    let message: Int
    let cnt: Int
    
    struct ListItem: Codable {
        let dt: Int
        
        struct Main: Codable {
            let temp: Double
        }
        
        let main: Main
        
        struct Weather: Codable {
            let description: String
            let icon: String
        }
        
        let weather: [Weather]
    }
    
    let list: [ListItem]
}

struct ForecastData {
    let date: Date
    let icon: String
    let weather: String
    let temperature: Double
}
