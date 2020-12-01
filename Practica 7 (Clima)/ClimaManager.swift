//
//  ClimaManager.swift
//  Practica 7 (Clima)
//
//  Created by Ingrid on 22/11/20.
//

import Foundation

protocol ClimaManagerDelegate {
    func Actualizar(clima: ClimaModelo)
    func Error(error: Error)
}

struct ClimaManager {
    var delegado: ClimaManagerDelegate?
    let url = "https://api.openweathermap.org/data/2.5/weather?appid=698cb29c0a1e70d1a30a0a9982f6a95a&units=metric&lang=es"
    
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
            delegado?.Error(error: error!)
            return
        }
        if let datos = data {
            if let clima = self.Decodificar(clima: datos) {
                delegado?.Actualizar(clima: clima)
            }
        }
    }
    
    func Decodificar(clima: Data) -> ClimaModelo? {
        let decoder = JSONDecoder()
        do {
            let decoded = try decoder.decode(ClimaData.self, from: clima)
            let id = decoded.weather[0].id
            let ciudad = decoded.name
            let descripcion = decoded.weather[0].description
            let temperatura = decoded.main.temp
            let sensacion = decoded.main.feels_like
            let maxima = decoded.main.temp_max
            let minima = decoded.main.temp_min
            let humedad = decoded.main.humidity
            let velocidad = decoded.wind.speed
            let direccion = decoded.wind.deg
            let clima = ClimaModelo(id: id, ciudad: ciudad, descripcion: descripcion, temperatura: temperatura, sensacion: sensacion, maxima: maxima, minima: minima, humedad: humedad, velocidad: velocidad, direccion: direccion)
            return clima
        }
        catch {
            //print(error)
            delegado?.Error(error: error)
            return nil
        }
    }
}
