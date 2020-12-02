//
//  ClimaData.swift
//  Practica 7 (Clima)
//
//  Created by Ingrid on 23/11/20.
//

import Foundation

struct ClimaData: Codable {
    let name: String
    let cod: Int
    let coord: Coord
    let weather: [Weather]
    let main: Main
    let wind: Wind
}

struct Coord: Codable{
    let lat: Double
    let lon: Double
}

struct Weather: Codable {
    let id: Int
    let description: String
}

struct Main: Codable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let humidity: Int
}

struct Wind: Codable {
    let speed: Double
    let deg: Double
}
