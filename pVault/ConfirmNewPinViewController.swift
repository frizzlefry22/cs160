//
//  ConfirmNewPinViewController.swift
//  pVault
//
//  Created by !Lashkar Singh on 12/12/14.
//  Copyright (c) 2014 Pvault2. All rights reserved.
//

import UIKit

class ConfirmNewPinViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var pinField:UITextField!;
    @IBOutlet weak var confirmPINField:UITextField!;
    
    @IBOutlet weak var warningConfirmPINLabel:UILabel!;
    
    @IBOutlet weak var confirmButton:UIButton!;
    
    //var user:PFObject!;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.pinField.delegate = self;
        self.confirmPINField.delegate = self;
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
    
    @IBAction func pinChanged(sender: AnyObject) {
        
        if ( Validator.validPin(pinField.text)) {
            warningConfirmPINLabel.text = "Valid"
            warningConfirmPINLabel.textColor = UIColor.greenColor()
        }
        else {
            warningConfirmPINLabel.text = "Invalid"
            warningConfirmPINLabel.textColor = UIColor.redColor()
        }
        
        checkForMatching()
    }
    
    @IBAction func confirm(sender: AnyObject) {
        
        //create copy of LoggedInuser
        var newUser = LoggedInuser.copy()
        newUser.setPIN(pinField.text)
        
        //edit user in DB
        //*** FOR SOME REASON, when you try to step over this, xcode crashes, works if you just hit continue, dunno why ***
        UserDatabaseConnection.edit(LoggedInuser, updated: newUser)
        
        //here is where I should save locally, leave it like this for now for testing
        LoggedInuser.setPIN(pinField.text)
        //println(LoggedInuser.getPassword())
        
        returnToSettings();
    }
    
    func checkForMatching() {
        
        var match = Validator.matches(pinField.text, s2 : confirmPINField.text)
        
        if (pinField.text.isEmpty)
        {
            warningConfirmPINLabel.text = ""
        }
        else if (!pinField.text.isEmpty && !confirmPINField.text.isEmpty)
        {
            if ( match ) {
                warningConfirmPINLabel.text = "Matches"
                warningConfirmPINLabel.textColor = UIColor.greenColor()
            }
            else {
                warningConfirmPINLabel.text = "Does not match"
                warningConfirmPINLabel.textColor = UIColor.redColor()
            }
        }
        
        updateConfirmButton(match)
    }
    
    @IBAction func confirmPINChanged(sender: AnyObject) {
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
        pinField.text = "";
        confirmPINField.text = "";
        
        pinField.becomeFirstResponder(); // <-- Moves cursor back to PIN field
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
    
    //remove keyboard
    override func touchesBegan(touches: NSSet?, withEvent event: UIEvent?) {
        
        self.view.endEditing(true)
        
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
