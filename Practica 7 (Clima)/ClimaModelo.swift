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
    
    var condicion: String {
        switch id {
        case 300...321:
            return "icon-rainy.svg"
        case 600...622:
            return "icon-snowy.svg"
        case 701...781:
            return "icon-windy.svg"
        case 801...804:
            return "icon-cloudy.svg"
        case 800:
            return "icon-sunny.svg"
        default:
            return "icon-partially-cloudy.svg"
        }
    }
    
    var TDecimal: String {
        return String(format: "%.1f", temperatura)
    }
}
