//
//  ConfirmRegisterViewController.swift
//  pVault
//
//  Created by Joseph ORLANDO on 11/24/14.
//  Copyright (c) 2014 Pvault2. All rights reserved.
//

import UIKit

class ConfirmRegisterViewController: UIViewController, UITextFieldDelegate, Alertable{

    
    
    @IBOutlet weak var emailTextBox: UITextField!
    
    
    
    @IBAction func debugButtonForNow(sender: AnyObject) {
        
        //Sets Delegate needed for Alert
        UserDatabaseConnection.AlertDelStuct.alertDelegate = self
        
        RegisterInfo.createUser()
        
        
    }
    
    func AlertUser(message: String) {
        let alertController = UIAlertController(title: "Create User", message: "Successful", preferredStyle: .Alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .Default) {
            (action) in
            
            self.moveBack(7)
            
        }
        
        alertController.addAction(okAction)
        
        self.presentViewController(alertController,animated:true) {
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.emailTextBox.delegate = self
        emailTextBox.text = RegisterInfo.email
        emailTextBox.enabled = false
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //hides the keyboard when you hit return
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        
        self.view.endEditing(true);
        return false;
    }

    
    //param: takes in number of screens to move back
    //to move from confirm screen back to home
    func moveBack(num : Int)
    {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController];
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - num], animated: true);
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
