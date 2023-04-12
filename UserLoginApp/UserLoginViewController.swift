//
//  ViewController.swift
//  UserLoginApp
//
//  Created by Kushal Rana on 11/04/23.
//

import UIKit
import CoreData

class UserLoginViewController: UIViewController {
    
   
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var pincodeLabel: UILabel!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var pincodeTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func loginButton(_ sender: Any) {
    if firstNameTextField.text != "" && lastNameTextField.text != "" && emailTextField.text != "" && passwordTextField.text != "" && addressTextField.text != "" && pincodeTextField.text != "" {
       
        if let firstName = firstNameTextField.text, let lastName = lastNameTextField.text, let email = emailTextField.text, let password = passwordTextField.text, let  pincode = pincodeTextField.text, let  address = addressTextField.text {
                
                saveValuesInDatabase (firstName: firstName , lastName: lastName , email: email , password: password , address: address , pincode: pincode)
            
            firstNameTextField.text = ""
            lastNameTextField.text = ""
            emailTextField.text = ""
            passwordTextField.text = ""
            addressTextField.text = ""
            pincodeTextField.text = ""
            
            }
    }
    else {
        print("enter first name")
        print("enter last name")
        print("enter email")
        print("enter password")
        print("enter address")
        print("enter pincode")
    }
}
    
    func saveValuesInDatabase (firstName: String, lastName: String, email: String, password: String, address: String, pincode:String) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "UserDetails", in: context)
        
        if let entity = entity {
            
            let newUser = NSManagedObject(entity: entity, insertInto: context)
            
            newUser.setValue(firstName, forKey: "firstName")
            newUser.setValue(lastName, forKey: "lastName")
            newUser.setValue(email, forKey: "email")
            newUser.setValue(password, forKey: "password")
            newUser.setValue(address, forKey: "address")
            newUser.setValue(pincode, forKey: "pincode")
            
            do {
                try context.save()
                print("data saved")
            }catch{
                debugPrint("cant save")
            }
        }
        
    }
    
}



