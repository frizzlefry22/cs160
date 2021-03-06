//
//  CreatePasswordPINViewController.swift
//  pVault
//
//  Created by Joseph ORLANDO on 11/18/14.
//  Copyright (c) 2014 Pvault2. All rights reserved.
//

import UIKit

class CreatePasswordPINViewController: UIViewController, UITextFieldDelegate {
    
    
    //Bools that decide if can proceed
    var validPassword = false
    var validPIN = false
    var matchingPassword = false
    var matchingPIN = false
    
    @IBOutlet weak var passwordWarning: UILabel!
    
    @IBOutlet weak var passConfirm: UITextField!
    
    @IBOutlet weak var pass: UITextField!
    
    @IBOutlet weak var pinCode: UITextField!
    
    @IBOutlet weak var pinCodeWarning: UILabel!
    
    @IBOutlet weak var pinCodeConfirmed: UITextField!
    
    @IBOutlet weak var pinMatchWarning: UILabel!
    
    @IBOutlet weak var continueButton: UIButton!
    
    @IBOutlet weak var passMatchWarning: UILabel!
    
    @IBAction func passwordTextEntered(sender: AnyObject) {
        
        if ( Validator.passwordIsValid(pass.text)){
            passwordWarning.text = "Valid"
            passwordWarning.textColor = UIColor.greenColor()
            
            validPassword = true
        }
        else {
            pass.textColor = UIColor.blackColor()
            passwordWarning.text = "Invalid"
            passwordWarning.textColor = UIColor.redColor()
            
            validPassword = false
        }
        updatePassWordWarning()
        updateContinue()
        
    }

    @IBAction func passConfrimEdited(sender: AnyObject) {
    
        if ( Validator.matches (  pass.text, s2 : passConfirm.text)){
            matchingPassword = true
        }
        else {
            matchingPassword = false
        }
        updatePassWordWarning()
        updateContinue()
    }
    
    @IBAction func pinEdited(sender: AnyObject) {
        
        if (Validator.validPin(pinCode.text))
        {
            validPIN = true
        }
        else {
            validPIN = false
        }
        updatePinWarning()
        updateContinue()
    }
    
    @IBAction func pinConfirmEdited(sender: AnyObject) {
        
        if (Validator.matches(pinCode.text, s2 : pinCodeConfirmed.text))
        {
            matchingPIN = true
        }
        else {
            matchingPIN = false
        }
        updatePinWarning()
        updateContinue()
    }
    
    func updatePassWordWarning() {
        if (Validator.matches(pass.text, s2 : passConfirm.text)){
            passMatchWarning.text = "Match"
            passMatchWarning.textColor = UIColor.greenColor()
        }
        else {
            passMatchWarning.text = "Does not match"
            passMatchWarning.textColor = UIColor.redColor()
        }
    }
    
    func updatePinWarning() {
        if (Validator.matches(pinCode.text, s2 : pinCodeConfirmed.text)) {
            pinMatchWarning.text = "Matches"
            pinMatchWarning.textColor = UIColor.greenColor()
        }
        else {
            pinMatchWarning.text = "Does not Match"
            pinMatchWarning.textColor = UIColor.redColor()
        }
    }
    
    //Updates the Continue button
    func updateContinue() {
        if (validPassword && validPIN && matchingPassword && matchingPIN){
            
            continueButton.enabled = true
            continueButton.alpha = 1
        }
        else {
            
            continueButton.enabled = false
            continueButton.alpha = 0.4
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        //Set the password
        RegisterInfo.passWord = pass.text!
        
        //
        RegisterInfo.pinCode = pinCode.text!
        
        //Resets the Security Question Bank for hte next screen
        SecurityQuestions.resetQuestionBank()
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.passConfirm.delegate = self;
        self.pass.delegate = self;
        self.pinCode.delegate = self;
        self.pinCodeConfirmed.delegate = self;
        
        continueButton.alpha = 0.4
        continueButton.enabled = false
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //removes keyboard
    override func touchesBegan(touches: NSSet?, withEvent event: UIEvent?) {
        self.view.endEditing(true)
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
