//
//  HomeViewController.swift
//  pVault
//
//  Created by Joseph ORLANDO on 12/14/14.
//  Copyright (c) 2014 Pvault2. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, Alertable {

    
    var user : User!
    
    
    
    func AlertUser(message : String) {
        /*var messageA: String!
        
        
        let alertController = UIAlertController(title: "Status", message: message, preferredStyle: .Alert)
        
        
        
        let okAction = UIAlertAction(title: "Ok", style: .Default) {
            (action) in
            
        }
        
        //dispatch_async(dispatch_get_main_queue(), {
            alertController.addAction(okAction)
            self.navigationController?.topViewController.presentViewController(alertController, animated: true, completion: {})
        //})*/
        DocumentDBConnection.AlertDelStuct.alertDelegate = self
        println("I'm here")
        let actionSheetController: UIAlertController = UIAlertController(title: "Action Sheet", message: "Swiftly Now! Choose an option!", preferredStyle: .ActionSheet)
        
        //Create and add the Cancel action
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
            //Just dismiss the action sheet
        }
        actionSheetController.addAction(cancelAction)
        //Create and add first option action
        let takePictureAction: UIAlertAction = UIAlertAction(title: "Take Picture", style: .Default) { action -> Void in
            //Code for launching the camera goes here
        }
        actionSheetController.addAction(takePictureAction)
        //Create and add a second option action
        let choosePictureAction: UIAlertAction = UIAlertAction(title: "Choose From Camera Roll", style: .Default) { action -> Void in
            //Code for picking from camera roll goes here
        }
        actionSheetController.addAction(choosePictureAction)
        
        //We need to provide a popover sourceView when using it on iPad
        //actionSheetController.popoverPresentationController?.sourceView
        
        //Present the AlertController
        self.presentViewController(actionSheetController, animated: true, completion: nil)
    }
    @IBOutlet weak var userNameTextUI: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        userNameTextUI.text = user.getEmail()
        //gets list of document tuples
        
        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        dispatch_async(queue, {
            docList = DocumentDBConnection.getDocList(LoggedInuser.getUserID())
        })
        
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func createDocumentPressed(sender: AnyObject) {
        let storyboard : UIStoryboard = UIStoryboard(name: "Document", bundle: nil);
        let vc : UIViewController = storyboard.instantiateViewControllerWithIdentifier("DocStoryBoard") as UIViewController;
        self.navigationController?.pushViewController(vc,animated : true);

    }
    
    
    @IBAction func viewRemoteDocsPressed(sender: AnyObject) {
        let storyboard : UIStoryboard = UIStoryboard(name: "Document", bundle: nil);
        let vc : UIViewController = storyboard.instantiateViewControllerWithIdentifier("list") as UIViewController;
        self.navigationController?.pushViewController(vc,animated : true);

    }

    @IBAction func viewLocalDocsPressed(sender: AnyObject) {
     
        let storyboard : UIStoryboard = UIStoryboard(name: "Document", bundle: nil);
        let vc : UIViewController = storyboard.instantiateViewControllerWithIdentifier("LocalDocument") as UIViewController;
        self.navigationController?.pushViewController(vc,animated : true);
    }
    
    @IBAction func syncLocalDocsPressed(sender: AnyObject) {
        LocalFileManager.syncDocuments(LoggedInuser)
    }
    
    @IBAction func settingsPressed(sender: AnyObject) {
//        let storyboard : UIStoryboard = UIStoryboard(name: "Settings", bundle: nil);
//        let vc : UIViewController = storyboard.instantiateViewControllerWithIdentifier("Settings") as UIViewController;
//        self.navigationController?.pushViewController(vc, animated: true);

        if(!Reachability.isConnectedToNetwork()){
            let alertController = UIAlertController(title: "No Internet Connection", message: "Can't accesses settings without internet", preferredStyle: .Alert)
            
            //add confirm action
            let confirmAction = UIAlertAction(title: "Ok", style: .Default) { (action) in}
            alertController.addAction(confirmAction)
            
            self.presentViewController(alertController,animated:true) {}
        }
        else{
            let storyboard : UIStoryboard = UIStoryboard(name: "Settings", bundle: nil);
            let vc : UIViewController = storyboard.instantiateViewControllerWithIdentifier("Settings") as UIViewController;
            self.navigationController?.pushViewController(vc, animated: true);
        }

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
