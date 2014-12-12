//
//  ConfirmRegisterViewController.swift
//  pVault
//
//  Created by Joseph ORLANDO on 11/24/14.
//  Copyright (c) 2014 Pvault2. All rights reserved.
//

import UIKit

class ConfirmRegisterViewController: UIViewController, Alertable {

    
    
    @IBOutlet weak var emailTextBox: UITextField!
    
    
    
    @IBAction func debugButtonForNow(sender: AnyObject) {


        //Set this so can alert user
        UserDatabaseConnection.AlertDelStuct.alertDelegate = self
        
        
        RegisterInfo.createUser()
        
    
        

    }

    func AlertUser ( message : String ) {
        
        let alertController = UIAlertController(title: "User Registered", message: message, preferredStyle: .Alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .Default) {
            (action) in
        }
        
        alertController.addAction(okAction)
        
        self.presentViewController(alertController,animated:true) {
            
        }

    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailTextBox.text = RegisterInfo.email
        emailTextBox.enabled = false
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
