//
//  LoginViewController.swift
//  pVault
//
//  Created by Joseph ORLANDO on 11/18/14.
//  Copyright (c) 2014 Pvault2. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate , Alertable {

    var user : User!
    
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
    
    
    func AlertUser(message: String) {
        let alertController = UIAlertController(title: "Login Failed", message: message, preferredStyle: .Alert)
        
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
        let storyboard : UIStoryboard = UIStoryboard(name: "Document", bundle: nil);
        let vc : UIViewController = storyboard.instantiateViewControllerWithIdentifier("list") as UIViewController;
//        let storyboard : UIStoryboard = UIStoryboard(name: "KevinTesting", bundle: nil);
//        let vc : UIViewController = storyboard.instantiateViewControllerWithIdentifier("testEdit") as UIViewController;
        //self.presentViewController(vc, animated: true, completion: nil);
        self.navigationController?.pushViewController(vc,animated : true);
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
        
        //Alert User that email doesnt exist
        if ( checkUser.getEmail() == "" )
        {
            AlertUser("User does not exist:")
            return
        }
        
        let passWordCorrect = loginPassword.text! == checkUser.getPassword()
        
        // Aert User that Password is incorrect
        if ( !passWordCorrect )
        {
            AlertUser("Password inccorect")
            return
        }
    
        
        if(loginEmail.text! != "") && (loginEmail.text! == checkUser.getEmail()){
            println("login success")
            
            if !LocalFileManager.checkUserDirectory(checkUser.getEmail()){
                LocalFileManager.createUserDirectory(checkUser.getEmail())
            }
            
            LocalFileManager.addUser(checkUser, temp: false)
            
            self.user = checkUser.copy()
            LoggedInuser = self.user.copy()
            
            //Goes to the Home screen
            performSegueWithIdentifier("Home", sender: sender)
            
            
        }else{
            println("login fail")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginEmail.delegate = self;
        self.loginPassword.delegate = self;
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

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
        if ( segue.identifier == "Home" )
        {
            
            let vc = segue.destinationViewController as HomeViewController
            
            vc.user = self.user
        }
     
        
    }
    

}
