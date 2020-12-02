//
//  ForecastData.swift
//  Practica 7 (Clima)
//
//  Created by Ingrid on 01/12/20.
//

import Foundation

struct ForecastData: Codable {
    let list: [List]
}

struct List: Codable {
    let weather: [WeatherF]
    let main: MainF
    let dt_txt: String
}

struct WeatherF: Codable {
    let id: Int
    let description: String
}

struct MainF: Codable {
    let temp: Double
}
