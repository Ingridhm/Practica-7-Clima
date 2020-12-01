//
//  ClimaModelo.swift
//  Practica 7 (Clima)
//
//  Created by Ingrid on 23/11/20.
//

import Foundation

struct ClimaModelo {
    let id: Int
    let ciudad: String
    let descripcion: String
    let temperatura: Double
    let sensacion: Double
    let maxima: Double
    let minima: Double
    let humedad: Int
    let velocidad: Double
    let direccion: Int
    
    var condicion: String {
        switch id {
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
    
    var background: String {
        switch id {
        case 200...232:
            return "background-thunderstorm-day.jpg"
        case 300...321:
            return "background-drizzle-night.jpg"
        case 500...531:
            return "background-drizzle-night.jpg"
        case 600...622:
            return "background-snowy-day.jpg"
        case 701...781:
            return "backgound-foggy-day.jpg"
        case 801...804:
            return "background-cloudy-night.jpg"
        case 800:
            return "background-clear-day.jpg"
        default:
            return "amanecer.jpg"
        }
    }
    
    var TDecimal: String {
        return String(format: "%.1f", temperatura)
    }
    
    var Sensacion: String {
        return String(format: "%.1f", sensacion)
    }
    
    var Maxima: String {
        return String(format: "%.1f", maxima)
    }
    
    var Minima: String {
        return String(format: "%.1f", minima)
    }
    
    var Velocidad: String {
        return String(format: "%.1f", velocidad)
    }
}
