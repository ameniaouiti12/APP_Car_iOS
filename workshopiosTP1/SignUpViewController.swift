//
//  SignUpViewController.swift
//  workshopiosTP1
//
//  Created by Mac2021 on 20/10/2024.
//

import UIKit
import CoreData

class SignUpViewController: UIViewController{

    
    //outlet
    
    
    @IBOutlet weak var nametext: UITextField!
    
    @IBOutlet weak var usernameText: UITextField!
    
    
    @IBOutlet weak var passwordText: UITextField!
    
    @IBOutlet weak var confirmPasswordText: UITextField!
    
    
    
    
    @IBAction func SignUpButtnTapped(_ sender: Any) {
        
        let name = nametext.text ?? ""
        let username = usernameText.text ?? ""
        let password = passwordText.text ?? ""
        let confirmPassword = confirmPasswordText.text ?? ""
        
        // verificationdes champs
        if name.isEmpty || username.isEmpty || password.isEmpty || confirmPassword.isEmpty {
            showAlert(message: "please complet all fields")
            return
            
        }
        // verification que le mot passe et la confirmation correspondante
        if password != confirmPassword {
            showAlert(message: "password incorrect !!!!")
            return
        }
        // sauvegarder l'utilisateur dans core data
        saveUser(name: name, username: username, password: password)
        showAlert(message: "SUCCESSFUL REGISTRATION ")
    }
    
    // methode pour sauvegarde un nouvel user dans core data
    
    func saveUser(name: String, username: String, password: String){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "User", in: context)!
        let newUser = NSManagedObject(entity: entity,  insertInto: context)
        
        newUser.setValue(name, forKey: "name")
        newUser.setValue(username, forKey: "username")
        newUser.setValue(password, forKey: "password")
        
        do {
            try context.save()
            print("user saved")
        }catch{
            print("error saved user")
        }
    }
    
    // methode pour affichr une alert
    func showAlert(message: String){
        let alert = UIAlertController(title: "Attention", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
