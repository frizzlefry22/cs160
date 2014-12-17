//
//  ConfirmResetViewController.swift
//  pVault
//
//  Created by Joseph ORLANDO on 12/10/14.
//  Copyright (c) 2014 Pvault2. All rights reserved.
//

import UIKit

class ConfirmResetViewController: UIViewController, UITextFieldDelegate, Alertable  {

    var userEmail : String!
    
    @IBOutlet weak var warningPassword: UILabel!
    
    @IBOutlet weak var warningConfirmPassword: UILabel!
    
    @IBOutlet weak var newPassword: UITextField!
    
    @IBOutlet weak var confirmPassword: UITextField!
    
    
    @IBAction func passwordChanged(sender: AnyObject) {
        
        if ( Validator.isValidPassword(newPassword.text)) {
            warningPassword.text = "Valid"
            warningPassword.textColor = UIColor.greenColor()
        }
        else {
            warningPassword.text = "Invalid"
            warningPassword.textColor = UIColor.redColor()
        }
        
        checkForMatching()
    }

    
    @IBAction func resetClicked(sender: AnyObject) {
        
        UserDatabaseConnection.AlertDelStuct.alertDelegate = self
        
        //create copy of LoggedInuser
        var newUser = UserDatabaseConnection.getUserByEmail(self.userEmail)
        LoggedInuser = newUser.copy()
        newUser.setPassword(newPassword.text)
        
        //edit user in DB
        //*** FOR SOME REASON, when you try to step over this, xcode crashes, works if you just hit continue, dunno why ***
        UserDatabaseConnection.edit(LoggedInuser, updated: newUser)
        
        //here is where I should save locally, leave it like this for now for testing
        //LoggedInuser.setPassword(newPassword.text)
        //println(LoggedInuser.getPassword())
    }
    
    
    
    
    func checkForMatching() {
        
        var match = Validator.matches(newPassword.text, s2 : confirmPassword.text)
       
        if ( confirmPassword.text.isEmpty)
        {
            warningConfirmPassword.text = ""
        }
        else {
            if ( match ) {
                warningConfirmPassword.text = "Matches"
                warningConfirmPassword.textColor = UIColor.greenColor()
            }
            else {
                warningConfirmPassword.text = "Does not match"
                warningConfirmPassword.textColor = UIColor.redColor()
            }
        }
        
        updateResetButton(match)
        
    }
    
    func updateResetButton( cont : Bool) {
        if (cont) {
            resetPasswordButton.enabled = true
            resetPasswordButton.alpha = 1
        }
        else {
            resetPasswordButton.enabled = false
            resetPasswordButton.alpha = 0.4
        }
    }
    
    @IBOutlet weak var resetPasswordButton: UIButton!
    
    @IBAction func confirmPasswordChanged(sender: AnyObject) {
        checkForMatching()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.newPassword.delegate = self;
        self.confirmPassword.delegate = self;
        resetPasswordButton.alpha = 0.4
        resetPasswordButton.enabled = false
        
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
