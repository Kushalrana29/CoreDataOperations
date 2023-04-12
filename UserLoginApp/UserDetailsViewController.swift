//
//  UserDetailsViewController.swift
//  UserLoginApp
//
//  Created by Kushal Rana on 11/04/23.
//

import UIKit
import CoreData

class UserDetailsViewController: UIViewController {

    @IBOutlet weak var detailsTableView: UITableView!
    
    var detailsArray = [AnyObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        detailsTableView.delegate = self
        detailsTableView.dataSource = self
    }
    
    func fetchData (){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserDetails")
        request.returnsObjectsAsFaults = false
        
        do{
            let result = try context.fetch(request)
            detailsArray = result
            DispatchQueue.main.async {
                self.detailsTableView.reloadData()
            }
        }catch{
            
        }
    }
}
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
            let appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
            let context:NSManagedObjectContext = appDel.persistentContainer.viewContext
            
            context.delete(detailsArray[indexPath.row] as! NSManagedObject)
            detailsArray.remove(at: indexPath.row)
            self.detailsTableView.reloadData()
            do {
                try context.save()
                } catch let error as NSError {
                    print(error)
                }
        default:
            return
        }
    }
    
    
//
//     func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCell.EditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//            switch editingStyle {
//            case .delete:
//                // remove the deleted item from the model
//                let appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
//                let context:NSManagedObjectContext = appDel.persistentContainer.viewContext
//
//                context.delete(detailsArray[indexPath.row] as! NSManagedObject)
//                detailsArray.remove(at: indexPath.row)
//
////                do{
////                    try context.save()
////                    }
////                }catch{
////
////                }
//
//
//
//               //tableView.reloadData()
//                // remove the deleted item from the `UITableView`
//              //  self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
//            default:
//                return
//
//            }
    //}
    
    
}
