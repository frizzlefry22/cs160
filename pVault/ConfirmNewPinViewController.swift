//
//  ConfirmNewPinViewController.swift
//  pVault
//
//  Created by Lashkar Singh on 12/12/14.
//  Copyright (c) 2014 Pvault2. All rights reserved.
//

import UIKit

class ConfirmNewPinViewController: UIViewController {

    @IBOutlet weak var pinField:UITextField!;
    @IBOutlet weak var confirmPINField:UITextField!;
    
    @IBOutlet weak var pinsDontMatchLabel:UILabel!;
    
    //var user:PFObject!;
    
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
    
    @IBAction func confirm()
    {
        if (pinsMatch())
        {
            var PIN = pinField.text;
            
            var userQuery = PFQuery(className:"User");
            userQuery.whereKey("email", equalTo:LoggedInuser.getEmail());
            var searchResults:NSArray = userQuery.findObjects();
            var parseUser:PFObject = searchResults.firstObject as PFObject;
            
            parseUser["PIN"] = PIN;
            parseUser.save();
            
            returnToSettings();
        }
        else
        {
            clearFields();
            pinsDontMatchLabel.hidden = false;
        }
    }
    
    func pinsMatch() -> Bool
    {
        var PIN = pinField.text;
        var confirmPIN = confirmPINField.text;
        
        return PIN == confirmPIN;
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
