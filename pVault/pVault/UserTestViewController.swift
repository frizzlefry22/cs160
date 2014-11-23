//
//  UserTestViewController.swift
//  pVault
//
//  Created by Arjay Nguyen on 11/23/14.
//  Copyright (c) 2014 Pvault2. All rights reserved.
//

import UIKit

//Used to test UserDatabaseConnection
class UserTestViewController: UIViewController {

    //var userDB = UserDatabaseConnection()
    
    @IBAction func testCreate(sender: AnyObject) {
        UserDatabaseConnection.create(UserDatabaseConnection.testCreate())
        
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
