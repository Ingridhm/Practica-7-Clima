//
//  ViewController.swift
//  Practica 7 (Clima)
//
//  Created by Ingrid on 21/11/20.
//

import UIKit
import CoreLocation

 class ViewController: UIViewController {

    @IBOutlet weak var BuscarField: UITextField!
    @IBOutlet weak var ClimaImage: UIImageView!
    @IBOutlet weak var ClimaLabel: UILabel!
    @IBOutlet weak var TemperaturaLabel: UILabel!
    @IBOutlet weak var CiudadLabel: UILabel!
    @IBOutlet weak var BackgroundImage: UIImageView!
    @IBOutlet weak var TemperaturaView: UIView!
    @IBOutlet weak var BusquedaView: UIView!
    
    var climamanager = ClimaManager()
    var locationmanager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Estilos()
        climamanager.delegado = self
        BuscarField.delegate = self
        locationmanager.delegate = self
        locationmanager.requestWhenInUseAuthorization()
        locationmanager.requestLocation()
    }
    
    func Estilos() {
        TemperaturaView.backgroundColor = UIColor.gray.withAlphaComponent(0.6)
        TemperaturaView.layer.cornerRadius = 20
        BusquedaView.backgroundColor = UIColor.white.withAlphaComponent(0.6)
        BusquedaView.layer.cornerRadius = 10
    }
    
    
    @IBAction func UbicacionButton(_ sender: UIButton) {
        locationmanager.requestLocation()
    }
    
}

//MARK:- LocationManager
extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Se obtuvo la ubicación")
        if let ubicacion = locations.last {
            locationmanager.stopUpdatingLocation()
            let latitud = ubicacion.coordinate.latitude
            let longitud = ubicacion.coordinate.longitude
            print("Latitud: \(latitud), Longitud: \(longitud)")
            climamanager.ObtenerClima(latitud: latitud, longitud: longitud)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}

//MARK:- TexlField Changed
extension ViewController: UITextFieldDelegate {
    @IBAction func Buscar(_ sender: UIButton) {
        CiudadLabel.text = BuscarField.text
        climamanager.ObtenerClima(ciudad: BuscarField.text!)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(BuscarField.text!)
        CiudadLabel.text = BuscarField.text
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if (BuscarField.text != "") {
            return true
        }
        else {
            BuscarField.placeholder = "Ingresa una ciudad"
            return false
        }
    }
}

//MARK:- Actualizar UI
extension ViewController: ClimaManagerDelegate {
    func Actualizar(clima: ClimaModelo) {
        print(clima.descripcion)
        print(clima.TDecimal)
        DispatchQueue.main.async {
            self.ClimaLabel.text = clima.descripcion.capitalized
            self.TemperaturaLabel.text = "\(clima.TDecimal) °C"
            self.ClimaImage.image = UIImage(named: clima.condicion)
            self.BackgroundImage.image = UIImage(named: clima.background)
            self.CiudadLabel.text = clima.ciudad
        }
    }
    
    func Error(error: Error) {
        print(error.localizedDescription)
        DispatchQueue.main.async {
            self.CiudadLabel.text = error.localizedDescription
        }
    }
}
