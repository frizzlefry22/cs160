//
//  DeleteAccountViewController.swift
//  pVault
//
//  Created by Lashkar Singh on 12/12/14.
//  Copyright (c) 2014 Pvault2. All rights reserved.
//

import UIKit

class DeleteAccountViewController: UIViewController {

    @IBOutlet weak var pinTextField:UITextField!;
    @IBOutlet weak var wrongPINLabel:UILabel!;
    
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
        self.navigationController?.popViewControllerAnimated(true);
    }
    
    @IBAction func confirm()
    {
        if (pinTextField.text == LoggedInuser.getPIN())
        {
            var userQuery = PFQuery(className:"User");
            userQuery.whereKey("email", equalTo:LoggedInuser.getEmail());
            var searchResults:NSArray = userQuery.findObjects();
            var parseUser:PFObject = searchResults.firstObject as PFObject;
            
            parseUser.delete();
            self.navigationController?.popToRootViewControllerAnimated(true);
        }
        else
        {
            wrongPINLabel.hidden = false;
        }
   
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
