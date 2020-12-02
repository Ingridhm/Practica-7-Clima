//
//  ForecastManager.swift
//  Practica 7 (Clima)
//
//  Created by Ingrid on 01/12/20.
//

import Foundation

protocol ForecastManagerDelegate {
    func Actualizar(forecast: ForecastModelo)
    func Error(error: Error)
}

struct ForecastManager {
    var forecastdelegado: ForecastManagerDelegate?
    let url = "https://api.openweathermap.org/data/2.5/forecast?appid=698cb29c0a1e70d1a30a0a9982f6a95a&units=metric&lang=es"
    
    func ObtenerClima(ciudad: String) {
        let urls = "\(url)&q=\(ciudad)"
        print(urls)
        Solicitar(urls: urls)
    }
    
    func ObtenerClima(latitud: Double, longitud: Double) {
        let urls = "\(url)&lat=\(latitud)&lon=\(longitud)"
        Solicitar(urls: urls)
    }
    
    func Solicitar(urls: String) {
        if let url = URL(string: urls) {
            let session = URLSession(configuration: .default)
            let tarea = session.dataTask(with: url, completionHandler: Handle(data:respuesta:error:))
            tarea.resume()
        }
    }
    
    func Handle(data: Data?, respuesta: URLResponse?, error: Error?) {
        if (error != nil) {
            forecastdelegado?.Error(error: error!)
            return
        }
        if let datos = data {
            if let forecast = self.Decodificar(forecast: datos) {
                forecastdelegado?.Actualizar(forecast: forecast)
            }
        }
    }
    
    func Decodificar(forecast: Data) -> ForecastModelo? {
        let decoder = JSONDecoder()
        var fecha = [String]()
        var id = [Int]()
        var descripcion = [String]()
        var temperatura = [Double]()
        do {
            let decoded = try decoder.decode(ForecastData.self, from: forecast)
            //let id = decoded.list[1].weather[0].id
            //let descripcion = decoded.list[1].weather[0].description
            //let temperatura = decoded.list[1].main.temp
            for l in decoded.list {
                id.append(l.weather[0].id)
                descripcion.append(l.weather[0].description)
                temperatura.append(l.main.temp)
                fecha.append(l.dt_txt)
            }
            let forecast = ForecastModelo(id: id, descripcion: descripcion, temperatura: temperatura, fecha: fecha)
            return forecast
        }
        catch {
            forecastdelegado?.Error(error: error)
            return nil
        }
    }
}
