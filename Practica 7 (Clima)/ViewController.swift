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
    @IBOutlet weak var TemperaturaLabel: UILabel!
    @IBOutlet weak var CiudadLabel: UILabel!
    @IBOutlet weak var BackgroundImage: UIImageView!
    
    var manager = ClimaManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
            self.TemperaturaLabel.text = "\(clima.TDecimal) °C"
            self.ClimaImage.image = UIImage(named: clima.condicion)
            self.BackgroundImage.image = UIImage(named: clima.background)
        }
    }
    
}

