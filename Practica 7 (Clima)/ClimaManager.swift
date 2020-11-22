//
//  ClimaManager.swift
//  Practica 7 (Clima)
//
//  Created by Ingrid on 22/11/20.
//

import Foundation

struct ClimaManager {
    let clima = "https://api.openweathermap.org/data/2.5/weather?appid=698cb29c0a1e70d1a30a0a9982f6a95a&units=metrics"
    
    func ObtenerClima(ciudad: String) {
        let urls = "\(clima)&q=\(ciudad)"
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
            let d = String(data: datos, encoding: .utf8)
            print("Datos")
            print(d!)
            return
        }
    }
}
