//
//  DeleteAccountViewController.swift
//  pVault
//
//  Created by Lashkar Singh on 12/12/14.
//  Copyright (c) 2014 Pvault2. All rights reserved.
//

import UIKit

class DeleteAccountViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var pinTextField:UITextField!;
    @IBOutlet weak var wrongPINLabel:UILabel!;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.pinTextField.delegate = self;
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancel()
    {
        self.navigationController?.popViewControllerAnimated(true);
    }
    
    @IBAction func confirm()
    {
        if (pinTextField.text == LoggedInuser.getPIN())
        {

            let alertController = UIAlertController(title: "Confirm Deletion", message: "Deleting account", preferredStyle: .Alert)
            
            //add cancel action
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
                println(action)
            }
            alertController.addAction(cancelAction)
            
            //add confirm action
            let confirmAction = UIAlertAction(title: "Confirm", style: .Default) { (action) in
                //deletes user
                //delete user
                var userQuery = PFQuery(className:"User");
                userQuery.whereKey("email", equalTo:LoggedInuser.getEmail());
                UserDatabaseConnection.delete(userQuery);
                
                //delete all of user's documents
                var query = PFQuery(className:"Document")
                query.whereKey("userID", equalTo: LoggedInuser.getUserID())
                DocumentDBConnection.delete(query)
                
                //move back home
                self.navigationController?.popToRootViewControllerAnimated(true);
            }
            alertController.addAction(confirmAction)
            
            self.presentViewController(alertController,animated:true) {}
        }

        else
        {
            wrongPINLabel.hidden = false;
        }
   
    }

    //hides the keyboard when you hit return
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        
        self.view.endEditing(true);
        return false;
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
