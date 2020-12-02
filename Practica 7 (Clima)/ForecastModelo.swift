//
//  ForecastModelo.swift
//  Practica 7 (Clima)
//
//  Created by Ingrid on 01/12/20.
//

import Foundation

struct ForecastModelo {
    let id: [Int]
    let descripcion: [String]
    let temperatura: [Double]
    let fecha: [String]
    
    func Id(i: Int) -> String {
        switch i {
            case 200...232:
                return "icon-thunderstorm-day.svg"
            case 300...321:
                return "icon-drizzle-day.svg"
            case 500...531:
                return "icon-rainy-day.svg"
            case 600...622:
                return "icon-snowy-day.svg"
            case 701...781:
                return "icon-athmosphere-say.svg"
            case 801...804:
                return "icon-partially-cloudy-day.svg"
            case 800:
                return "icon-clear-day.svg"
            default:
                return "icon-cloudy-day.svg"
        }
    }
    
    func Temperatura(t: Double) -> String {
        return String(format: "%.1f", t)
    }

}
