//
//  LoginViewController.swift
//  workshopiosTP1
//
//  Created by Mac2021 on 20/10/2024.
//

import UIKit
import CoreData

class LoginViewController: UIViewController{

    
    //IBoutlet pour username et password
    
  
    @IBOutlet weak var usernameText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //Actiondu boutton login

    @IBAction func LoginButtonTapp(_ sender: UIButton) {
        
        let username = usernameText.text ?? ""
        let password = passwordText.text ?? ""
        
        //verificationdes champs
        if username.isEmpty || password.isEmpty {
            showAlert(message: "please fill in all field ")
            return
        }
        
        //appel a la methode de verification du login
        if checkLogin(username: username, password : password){
           performSegue(withIdentifier: "GoToHome", sender: nil)
            
        }else {
            showAlert(message: "Username Incorrect")
        }
    }
  
    
    
    
    func checkLogin(username: String, password: String)-> Bool {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return false
        }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "username == %@ AND password == %@", username, password)
        
        do {
            let users = try context.fetch(fetchRequest)
            return users.count > 0
        }catch {
            print("Error lors d la recuperation de donner :\(error.localizedDescription)")
            return false
        }
    }
    
    
    
    //methode pour affichr une alert
    func showAlert (message: String){
        let alert = UIAlertController(title: "Attention", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
