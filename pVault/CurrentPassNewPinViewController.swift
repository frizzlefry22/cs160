//
//  CurrentPassNewPinViewController.swift
//  pVault
//
//  Created by Lashkar Singh on 12/12/14.
//  Copyright (c) 2014 Pvault2. All rights reserved.
//

import UIKit

class CurrentPassNewPinViewController: UIViewController {

    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordWarningLabel: UILabel!;
    
    @IBAction func validatePass(sender: AnyObject)
    {
        var loggedInUser = LoggedInuser;
        if (passwordField.text == loggedInUser.getPassword())
        {
            var confirmNewPinViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ConfirmPin") as ConfirmNewPinViewController;
            self.navigationController?.pushViewController(confirmNewPinViewController, animated: true);
        }
        else
        {
            passwordWarningLabel.text = "Incorrect password";
        }
    }
    
    @IBAction func cancel(sender: AnyObject)
    {
        self.navigationController?.popViewControllerAnimated(true);
    }
    
    @IBAction func passwordEditChanged(sender: AnyObject)
    {
        if (passwordField.text.isEmpty)
        {
            passwordWarningLabel.text = "";
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
