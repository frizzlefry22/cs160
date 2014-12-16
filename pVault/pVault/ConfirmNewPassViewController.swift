//
//  ConfirmNewPassViewController.swift
//  pVault
//
//  Created by !Lashkar Singh on 12/12/14.
//  Copyright (c) 2014 Pvault2. All rights reserved.
//

import UIKit

class ConfirmNewPassViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var passwordField:UITextField!;
    @IBOutlet weak var confirmPasswordField:UITextField!;
    
    @IBOutlet weak var passwordsDontMatchLabel:UILabel!;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.passwordField.delegate = self;
        self.confirmPasswordField.delegate = self;

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancel()
    {
        returnToSettings();
    }
    
    @IBAction func confirm()
    {        
        if (passwordsMatch())
        {
            var password = passwordField.text;
            LoggedInuser.setPassword(password);   //update pass of logged user
                        
            var userQuery = PFQuery(className:"User");          //running query on parse
            userQuery.whereKey("email", equalTo:LoggedInuser.getEmail());
            var searchResults:NSArray = userQuery.findObjects();
            var parseUser:PFObject = searchResults.firstObject as PFObject;
            
            parseUser["password"] = password;
            parseUser.save();
            
            returnToSettings();
        }
        else
        {
            clearFields();
            passwordsDontMatchLabel.hidden = false;
        }
    }
    
    func passwordsMatch() -> Bool
    {        
        return passwordField.text == confirmPasswordField.text;
    }
    
    func clearFields()
    {
        passwordField.text = "";
        confirmPasswordField.text = "";
        
        passwordField.becomeFirstResponder(); // <-- Moves cursor back to password field
    }
    
    func returnToSettings()
    {
        var navStack = self.navigationController?.viewControllers;
        var newNavStack:NSMutableArray = NSMutableArray(array: navStack!);
        
        newNavStack.removeLastObject();
        newNavStack.removeLastObject();
        
        self.navigationController?.setViewControllers(newNavStack, animated: true);
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
