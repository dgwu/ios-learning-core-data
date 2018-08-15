//
//  ViewController.swift
//  CoreDataExample
//
//  Created by Daniel Gunawan on 15/08/18.
//  Copyright © 2018 Daniel Gunawan. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    var users = [User]()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var mainContext: NSManagedObjectContext?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainContext = appDelegate.persistentContainer.viewContext
        displayUsers()
    }
    
    func displayUsers() {
        // new keyword : generic
        let userRequest: NSFetchRequest<User> = User.fetchRequest()
        
        do {
            if let users =  try self.mainContext?.fetch(userRequest) {
                self.users = users
            }
        } catch  {
            print("error bruh")
        }
        
        var tempString = ""
        for user in self.users {
            if let email = user.email, let username = user.username {
                tempString += "\(email) - \(username) | "
            }
        }
        self.resultLabel.text = tempString
    }

    @IBAction func kepencet(_ sender: UIButton) {
        // make sure username and email are not empty and mainContext is not nil
        guard let username = usernameTextField.text, let email = emailTextField.text, let mainContext = mainContext else { return }
        
        let newUser = User(context: mainContext)
        newUser.email = email
        newUser.username = username
        
        // method 1
        appDelegate.saveContext()
        
        // method 2, but need to wrap it in try catch
//        mainContext.save()
        
        print("successfully persisted \(email) - \(username)")
        displayUsers()
    }
}

