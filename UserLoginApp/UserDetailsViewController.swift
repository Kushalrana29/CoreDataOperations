//
//  UserDetailsViewController.swift
//  UserLoginApp
//
//  Created by Kushal Rana on 11/04/23.
//

import UIKit
import CoreData

class UserDetailsViewController: UIViewController {

    //MARK: - IBOutlets
    
    @IBOutlet weak var detailsTableView: UITableView!
    
    
    //MARK: - Properties
    
    var detailsArray = [AnyObject]()
    
    
    //MARK: - Viewlife cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDataFromDB()
        
        detailsTableView.delegate = self
        detailsTableView.dataSource = self
    }
    
    
    
    //MARK: - fectch Data from core data
    
    func fetchDataFromDB (){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserDetails")
        request.returnsObjectsAsFaults = false
        
        do{
            let result = try delegateConext().1.fetch(request)
            detailsArray = result
            
            DispatchQueue.main.async {
                self.detailsTableView.reloadData()
            }
        } catch {
            print("Not saved:  getting error")
        }
    }
}

 
//MARK: - UITableViewDelegate, UITableViewDataSource

extension UserDetailsViewController : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 276
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        detailsArray.count
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"UserTableCell", for : indexPath) as! UserTableCell
        
        cell.firstNameLabel.text = (detailsArray[indexPath.row].value(forKey: "firstName")as! String)
        cell.lastNameLabel.text = (detailsArray[indexPath.row].value(forKey: "lastName")as! String)
        cell.emailLabel.text = (detailsArray[indexPath.row].value(forKey: "email")as! String)
        cell.passwordLabel.text = (detailsArray[indexPath.row].value(forKey: "password")as! String)
        cell.addressLabel.text = (detailsArray[indexPath.row].value(forKey: "address")as! String)
        cell.pincodeLabel.text = (detailsArray[indexPath.row].value(forKey: "pincode")as! String)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            delegateConext().1.delete(detailsArray[indexPath.row] as! NSManagedObject)
            detailsArray.remove(at: indexPath.row)
            self.detailsTableView.reloadData()
            do {
                try delegateConext().1.save()
                } catch let error as NSError {
                    print(error)
                }
        default:
            return
        }
    }
    
    func delegateConext() -> (AppDelegate, NSManagedObjectContext) {
        let appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.persistentContainer.viewContext
        return (appDel, context)
    }
    
}
