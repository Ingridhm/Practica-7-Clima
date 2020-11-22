//
//  ViewController.swift
//  Practica 7 (Clima)
//
//  Created by Ingrid on 21/11/20.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var BuscarField: UITextField!
    @IBOutlet weak var ClimaImage: UIImageView!
    @IBOutlet weak var TemperaturaLabel: UILabel!
    @IBOutlet weak var CiudadLabel: UILabel!
    
    let manager = ClimaManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
}

