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
    @IBOutlet weak var DetallesView: UIView!
    @IBOutlet weak var SensacionLabel: UILabel!
    @IBOutlet weak var MaximaLabel: UILabel!
    @IBOutlet weak var MinimaLabel: UILabel!
    @IBOutlet weak var HumedadLabel: UILabel!
    @IBOutlet weak var VientoView: UIView!
    @IBOutlet weak var VelocidadLabel: UILabel!
    @IBOutlet weak var DireccionLabel: UILabel!
    @IBOutlet weak var ForecastVew: UIView!
    @IBOutlet weak var Dia1Image: UIImageView!
    @IBOutlet weak var Dia2Image: UIImageView!
    @IBOutlet weak var Dia3Image: UIImageView!
    @IBOutlet weak var Dia4Image: UIImageView!
    @IBOutlet weak var Dia5Image: UIImageView!
    @IBOutlet weak var Dia1Label: UILabel!
    @IBOutlet weak var Dia2Label: UILabel!
    @IBOutlet weak var Dia3Label: UILabel!
    @IBOutlet weak var Dia4Label: UILabel!
    @IBOutlet weak var Dia5Label: UILabel!
    @IBOutlet weak var Fecha1Label: UILabel!
    @IBOutlet weak var Fecha2Label: UILabel!
    @IBOutlet weak var Fecha3Label: UILabel!
    @IBOutlet weak var Fecha4Label: UILabel!
    @IBOutlet weak var Fecha5Label: UILabel!
    
    
    var climamanager = ClimaManager()
    var forecastmanager = ForecastManager()
    var locationmanager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Estilos()
        climamanager.delegado = self
        forecastmanager.forecastdelegado = self
        BuscarField.delegate = self
        locationmanager.delegate = self
        locationmanager.requestWhenInUseAuthorization()
        locationmanager.requestLocation()
    }
    
    func Estilos() {
        BusquedaView.backgroundColor = UIColor.white.withAlphaComponent(0.6)
        BusquedaView.layer.cornerRadius = 10
        TemperaturaView.backgroundColor = UIColor.gray.withAlphaComponent(0.6)
        TemperaturaView.layer.cornerRadius = 20
        DetallesView.backgroundColor = UIColor.gray.withAlphaComponent(0.8)
        DetallesView.layer.cornerRadius = 10
        VientoView.backgroundColor = UIColor.gray.withAlphaComponent(0.8)
        VientoView.layer.cornerRadius = 10
        ForecastVew.backgroundColor = UIColor.gray.withAlphaComponent(0.8)
        ForecastVew.layer.cornerRadius = 10
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
            forecastmanager.ObtenerClima(latitud: latitud, longitud: longitud)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}

//MARK:- TexlField Changed
extension ViewController: UITextFieldDelegate {
    @IBAction func Buscar(_ sender: UIButton) {
        if (BuscarField.text == "") {
            let alert = UIAlertController(title: "Campo en blanco", message: "Por favor ingrese el nombre de una ciudad", preferredStyle: .alert)
            let aceptar = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
            alert.addAction(aceptar)
            present(alert, animated: true, completion: nil)
        }
        else {
            CiudadLabel.text = BuscarField.text
            climamanager.ObtenerClima(ciudad: BuscarField.text!)
            forecastmanager.ObtenerClima(ciudad: BuscarField.text!)
            BuscarField.text = ""
        }
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

//MARK:- Actualizar UI Clima
extension ViewController: ClimaManagerDelegate {
    func Actualizar(clima: ClimaModelo) {
        print("CLIMA")
        print("Descripción: \(clima.descripcion)")
        print("Temperatura: \(clima.Temperatura)")
        DispatchQueue.main.async {
            self.ClimaLabel.text = clima.descripcion.capitalized
            self.TemperaturaLabel.text = "\(clima.Temperatura) °C"
            self.ClimaImage.image = UIImage(named: clima.condicion)
            self.BackgroundImage.image = UIImage(named: clima.background)
            self.CiudadLabel.text = clima.ciudad
            self.SensacionLabel.text = "\(clima.Sensacion) °C"
            self.MaximaLabel.text = "\(clima.Maxima) °C"
            self.MinimaLabel.text = "\(clima.Minima) °C"
            self.HumedadLabel.text = "\(String(clima.humedad)) %"
            self.VelocidadLabel.text = "\(clima.velocidad) m/s"
            self.DireccionLabel.text = clima.Direccion
        }
    }
    
    func Error(error: Error) {
        print(error.localizedDescription)
        DispatchQueue.main.async {
            self.Limpiar()
            let alert = UIAlertController(title: "Ciudad no encontrada", message: "Por favor verifique que el nombre de la ciudad ingresada sea correcto", preferredStyle: .alert)
            let aceptar = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
            alert.addAction(aceptar)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func Limpiar() {
        CiudadLabel.text = "Desconocido"
        ClimaLabel.text = "-"
        TemperaturaLabel.text = "?"
        ClimaImage.image = UIImage(named: "icon-cloudy-day.svg")
        BackgroundImage.image = UIImage(named: "dawn.jpeg")
        SensacionLabel.text = "-"
        MaximaLabel.text = "_"
        MinimaLabel.text = "-"
        HumedadLabel.text = "-"
        VelocidadLabel.text = "-"
        DireccionLabel.text = "-"
        Dia1Image.image = UIImage(named: "icon-cloudy-day.svg")
        Dia1Label.text = "-"
        Dia2Image.image = UIImage(named: "icon-cloudy-day.svg")
        Dia2Label.text = "-"
        Dia3Image.image = UIImage(named: "icon-cloudy-day.svg")
        Dia3Label.text = "-"
        Dia4Image.image = UIImage(named: "icon-cloudy-day.svg")
        Dia4Label.text = "-"
        Dia5Image.image = UIImage(named: "icon-cloudy-day.svg")
        Dia5Label.text = "-"
        Fecha1Label.text = "Día 1"
        Fecha2Label.text = "Día 2"
        Fecha3Label.text = "Día 3"
        Fecha4Label.text = "Día 4"
        Fecha5Label.text = "Día 5"
    }
}

//MARK:- Actualizar UI Forecast
extension ViewController: ForecastManagerDelegate {
    func Actualizar(forecast: ForecastModelo) {
        DispatchQueue.main.async {
            self.Dia1Image.image = UIImage(named: forecast.Id(i: forecast.id[0]))
            self.Dia1Label.text = "\(forecast.Temperatura(t: forecast.temperatura[0])) °C"
            self.Dia2Image.image = UIImage(named: forecast.Id(i: forecast.id[6]))
            self.Dia2Label.text = "\(forecast.Temperatura(t: forecast.temperatura[6])) °C"
            self.Dia3Image.image = UIImage(named: forecast.Id(i: forecast.id[14]))
            self.Dia3Label.text = "\(forecast.Temperatura(t: forecast.temperatura[14])) °C"
            self.Dia4Image.image = UIImage(named: forecast.Id(i: forecast.id[30]))
            self.Dia4Label.text = "\(forecast.Temperatura(t: forecast.temperatura[30])) °C"
            self.Dia5Image.image = UIImage(named: forecast.Id(i: forecast.id[38]))
            self.Dia5Label.text = "\(forecast.Temperatura(t: forecast.temperatura[38])) °C"
            self.Fecha1Label.text = "12 / 03"
            self.Fecha2Label.text = "12 / 04"
            self.Fecha3Label.text = "12 / 05"
            self.Fecha4Label.text = "12 / 06"
            self.Fecha5Label.text = "12 / 07"
        }
    }
}
