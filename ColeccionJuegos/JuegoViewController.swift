//
//  JuegoViewController.swift
//  ColeccionJuegos
//
//  Created by Mac Tecsup on 23/09/17.
//  Copyright © 2017 Tecsup. All rights reserved.
//

import UIKit

class JuegoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBAction func eliminarTapped(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(juego!)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController!.popViewController(animated: true)
    }
    @IBOutlet weak var eliminarBoton: UIButton!
    @IBOutlet weak var JuegoImageView: UIImageView!
    @IBOutlet weak var tituloTextField: UITextField!
    
    @IBOutlet weak var agregarActualizarBoton: UIButton!
    var imagePicker = UIImagePickerController()
    var juego : Juego? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        
        if juego != nil{
            JuegoImageView.image = UIImage(data: (juego!.imagen!) as Data)
            tituloTextField.text = juego!.titulo
            agregarActualizarBoton.setTitle("Actualizar", for: .normal)
        }
        else{
            eliminarBoton.isHidden = true
        }

       
    }

    @IBAction func fotosTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let imagenSeleccionada = info[UIImagePickerControllerOriginalImage] as! UIImage
        JuegoImageView.image = imagenSeleccionada
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func camaraTapped(_ sender: Any) {
    }
    

    @IBAction func agregarTapped(_ sender: Any) {
        
        if juego != nil{
            juego!.titulo = tituloTextField.text
            juego!.imagen = UIImagePNGRepresentation(JuegoImageView.image!) as NSData?
            
        }
        else{
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let juego = Juego(context: context)
            juego.titulo = tituloTextField.text
            juego.imagen = UIImagePNGRepresentation(JuegoImageView.image!) as NSData?
        }
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController!.popViewController(animated: true)
        
    }
    
   
}
