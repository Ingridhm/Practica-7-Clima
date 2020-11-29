//
//  ViewController.swift
//  Practica 7 (Clima)
//
//  Created by Ingrid on 21/11/20.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, ClimaManagerDelegate {

    @IBOutlet weak var BuscarField: UITextField!
    @IBOutlet weak var ClimaImage: UIImageView!
    @IBOutlet weak var ClimaLabel: UILabel!
    @IBOutlet weak var TemperaturaLabel: UILabel!
    @IBOutlet weak var CiudadLabel: UILabel!
    @IBOutlet weak var BackgroundImage: UIImageView!
    @IBOutlet weak var TemperaturaView: UIView!
    @IBOutlet weak var BusquedaView: UIView!
    
    
    var manager = ClimaManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Estilos()
        manager.delegado = self
        BuscarField.delegate = self
    }

    @IBAction func Buscar(_ sender: UIButton) {
        CiudadLabel.text = BuscarField.text
        manager.ObtenerClima(ciudad: BuscarField.text!)
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
    
    func Actualizar(clima: ClimaModelo) {
        print(clima.descripcion)
        print(clima.TDecimal)
        DispatchQueue.main.async {
            self.ClimaLabel.text = clima.descripcion.capitalized
            self.TemperaturaLabel.text = "\(clima.TDecimal) °C"
            self.ClimaImage.image = UIImage(named: clima.condicion)
            self.BackgroundImage.image = UIImage(named: clima.background)
        }
    }
    
    func Estilos() {
        TemperaturaView.backgroundColor = UIColor.gray.withAlphaComponent(0.6)
        TemperaturaView.layer.cornerRadius = 20
        BusquedaView.backgroundColor = UIColor.white.withAlphaComponent(0.6)
        BusquedaView.layer.cornerRadius = 10
        
    }
}

