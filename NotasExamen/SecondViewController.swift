//
//  SecondViewController.swift
//  NotasExamen
//
//  Created by DAM on 28/2/17.
//  Copyright © 2017 DAM. All rights reserved.
//

import UIKit
import CoreData

class SecondViewController: UIViewController {

    @IBOutlet weak var asignatura: UITextField!
    @IBOutlet weak var aviso: UILabel!
    @IBOutlet weak var calificacion: UITextField!
    @IBOutlet weak var avisoRepetido: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        aviso.alpha=0
        avisoRepetido.alpha=0
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var save: UIButton!
    
    @IBAction func guardar(_ sender: Any) {
        var exist=false
        for i in 0 ..< notas.count{
            
            var asignaturaStr=notas[i].value(forKey: "asignatura") as! String
            var asignaturaTextField=asignatura.text
            if(asignaturaTextField!.lowercased()==asignaturaStr.lowercased()){
                exist=true
            }
        }
        if(exist==false){
            avisoRepetido.alpha=1
        if(calificacion.text!.lowercased()=="excelente"||calificacion.text!.lowercased()=="notable"||calificacion.text!.lowercased()=="bien"||calificacion.text!.lowercased()=="suficiente"||calificacion.text!.lowercased()=="insuficiente"){
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDel.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Nota", in: managedContext)
        let managedObject = NSManagedObject(entity: entity!, insertInto: managedContext)
        managedObject.setValue(asignatura.text!.lowercased(), forKeyPath: "asignatura")
        managedObject.setValue(calificacion.text!.lowercased(), forKeyPath: "calificacion")
        // Ahora lo guardarlo
        // Es necesario try / catch
        do {
            try managedContext.save()
            // La añadimos a nuestro array
            notas.append(managedObject)
            aviso.alpha=0
            self.navigationController?.popViewController(animated: true)
        } catch let error as NSError {
            print("Error: \(error), \(error.userInfo)")
        }
        }else{
            aviso.alpha=1
        }
        } else{
            avisoRepetido.alpha=1
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
