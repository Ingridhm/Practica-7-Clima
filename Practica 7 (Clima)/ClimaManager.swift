//
//  ClimaManager.swift
//  Practica 7 (Clima)
//
//  Created by Ingrid on 22/11/20.
//

import Foundation

protocol ClimaManagerDelegate {
    func Actualizar(clima: ClimaModelo)
}

struct ClimaManager {
    var delegado: ClimaManagerDelegate?
    let url = "https://api.openweathermap.org/data/2.5/weather?appid=698cb29c0a1e70d1a30a0a9982f6a95a&units=metric&lang=es"
    
    func ObtenerClima(ciudad: String) {
        let urls = "\(url)&q=\(ciudad)"
        print(urls)
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
            print("Error")
            print(error!)
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
            let clima = ClimaModelo(id: id, ciudad: ciudad, descripcion: descripcion, temperatura: temperatura)
            return clima
        }
        catch {
            print(error)
            return nil
        }
    }
}
