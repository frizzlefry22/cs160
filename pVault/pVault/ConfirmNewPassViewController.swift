//
//  ConfirmNewPassViewController.swift
//  pVault
//
//  Created by Lashkar Singh on 12/12/14.
//  Copyright (c) 2014 Pvault2. All rights reserved.
//

import UIKit

class ConfirmNewPassViewController: UIViewController {
    
    @IBOutlet weak var passwordField:UITextField!;
    @IBOutlet weak var confirmPasswordField:UITextField!;
    
    @IBOutlet weak var warningConfirmPasswordLabel:UILabel!;
    
    @IBOutlet weak var confirmButton:UIButton!;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    
    @IBAction func passwordChanged(sender: AnyObject) {
        
        if ( Validator.isValidPassword(passwordField.text)) {      //decide which one we using
            warningConfirmPasswordLabel.text = "Valid"
            warningConfirmPasswordLabel.textColor = UIColor.greenColor()
        }
        else {
            warningConfirmPasswordLabel.text = "Invalid"
            warningConfirmPasswordLabel.textColor = UIColor.redColor()
        }
        
        checkForMatching()
    }
    
    
    @IBAction func confirm(sender: AnyObject) {
        
        //create copy of LoggedInuser
        var newUser = LoggedInuser.copy()
        newUser.setPassword(passwordField.text)
        
        //edit user in DB
        //*** FOR SOME REASON, when you try to step over this, xcode crashes, works if you just hit continue, dunno why ***
        UserDatabaseConnection.edit(LoggedInuser, updated: newUser)
        
        //here is where I should save locally, leave it like this for now for testing
        LoggedInuser.setPassword(passwordField.text)
        //println(LoggedInuser.getPassword())
        
        returnToSettings();
    }
    
    func checkForMatching() {
        
        var match = Validator.matches(passwordField.text, s2 : confirmPasswordField.text)
        
        if (passwordField.text.isEmpty)
        {
            warningConfirmPasswordLabel.text = ""
        }
        else if (!passwordField.text.isEmpty && !confirmPasswordField.text.isEmpty)
        {
            if ( match ) {
                warningConfirmPasswordLabel.text = "Matches"
                warningConfirmPasswordLabel.textColor = UIColor.greenColor()
            }
            else {
                warningConfirmPasswordLabel.text = "Does not match"
                warningConfirmPasswordLabel.textColor = UIColor.redColor()
            }
        }
        
        updateConfirmButton(match)
    }
    
    @IBAction func confirmPasswordChanged(sender: AnyObject) {
        checkForMatching()
    }
    
    func updateConfirmButton( cont : Bool) {
        if (cont) {
            confirmButton.enabled = true
            confirmButton.alpha = 1
        }
        else {
            confirmButton.enabled = false
            confirmButton.alpha = 0.4
        }
    }
    
    func clearFields()
    {
        passwordField.text = "";
        confirmPasswordField.text = "";
        
        passwordField.becomeFirstResponder(); 
    }
    
    func returnToSettings()
    {
        var navStack = self.navigationController?.viewControllers;
        var newNavStack:NSMutableArray = NSMutableArray(array: navStack!);
        
        newNavStack.removeLastObject();
        newNavStack.removeLastObject();
        
        self.navigationController?.setViewControllers(newNavStack, animated: true);
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
