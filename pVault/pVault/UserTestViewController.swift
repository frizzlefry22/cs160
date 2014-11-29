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

    @IBAction func testDelete(sender: AnyObject) {
        UserDatabaseConnection.delete(UserDatabaseConnection.createTestQuery())
    }
    //var userDB = UserDatabaseConnection()
    
    @IBAction func testRead(sender: AnyObject) {
        var array: [[String:String]]
        var user: [String:String]
        //let storyboard = UIStoryboard(name: "Main", bundle:nil)
        //let vc = storyboard.instantiateViewControllerWithIdentifier("HomeView") as UIViewController
        //self.showViewController(vc as UIViewController, sender: vc)
        //self.presentViewController(vc, animated: false, completion: nil)
        array = UserDatabaseConnection.read(UserDatabaseConnection.createTestQuery())
        user = array[0]
        
        println(user["userID"])
        println(user["email"])
        println(user["PIN"])
        println(user["password"])
        println(user["secAns1"])
        println(user["secAns2"])
        println(user["secAns3"])
    }
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
