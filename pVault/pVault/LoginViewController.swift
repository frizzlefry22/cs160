//
//  LoginViewController.swift
//  pVault
//
//  Created by Joseph ORLANDO on 11/18/14.
//  Copyright (c) 2014 Pvault2. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBAction func moveToDocument(sender: AnyObject) {
        let storyboard : UIStoryboard = UIStoryboard(name: "Document", bundle: nil);
        let vc : UIViewController = storyboard.instantiateViewControllerWithIdentifier("DocStoryBoard") as UIViewController;
        //self.presentViewController(vc, animated: true, completion: nil);
        self.navigationController?.pushViewController(vc,animated : true);
    }
    
    @IBAction func aslert(sender: AnyObject) {
        
        let alertController = UIAlertController(title: "Document Upload", message: "Successful", preferredStyle: .Alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .Default) {
            (action) in
        }
        
        alertController.addAction(okAction)

        self.presentViewController(alertController,animated:true) {
            
        }
        
    }
    @IBAction func moveToArjayTest(sender: AnyObject) {
        
        let storyboard : UIStoryboard = UIStoryboard(name: "CoolTesting", bundle: nil);
        let vc : UIViewController = storyboard.instantiateViewControllerWithIdentifier("ArjayTestView") as UIViewController;
        self.presentViewController(vc, animated: true, completion: nil);
    }
    
    @IBAction func moveToSettings(sender: AnyObject) {
        let storyboard : UIStoryboard = UIStoryboard(name: "Settings", bundle: nil);
        let vc : UIViewController = storyboard.instantiateViewControllerWithIdentifier("Settings") as UIViewController;
        //self.presentViewController(vc, animated: true, completion: nil);
        self.navigationController?.pushViewController(vc, animated: true);
    }
    
    @IBAction func moveToKevinTest(sender: AnyObject) {
        let storyboard : UIStoryboard = UIStoryboard(name: "KevinTesting", bundle: nil);
        let vc : UIViewController = storyboard.instantiateViewControllerWithIdentifier("kevinStoryboard") as UIViewController;
        self.presentViewController(vc, animated: true, completion: nil);
    }
    
    @IBOutlet weak var loginEmail: UITextField!
    
    @IBOutlet weak var loginPassword: UITextField!
    
    @IBAction func checkLogin(sender: AnyObject) {
        var checkUser = User()
        if Reachability.isConnectedToNetwork(){
            checkUser = UserDatabaseConnection.getUserByEmail(loginEmail.text!)
        }else{
            checkUser = LocalFileManager.getUser(loginEmail.text!)
        }
        
        if(loginEmail.text! != "") && (loginEmail.text! == checkUser.getEmail()) && (loginPassword.text! == checkUser.getPassword()){
            println("login success")
            
            if !LocalFileManager.checkUserDirectory(checkUser.getEmail()){
                LocalFileManager.createUserDirectory(checkUser.getEmail())
            }
            
            LocalFileManager.addUser(checkUser, temp: false)
            
        }else{
            println("login fail")
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
