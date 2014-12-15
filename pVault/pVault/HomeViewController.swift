//
//  HomeViewController.swift
//  pVault
//
//  Created by Joseph ORLANDO on 12/14/14.
//  Copyright (c) 2014 Pvault2. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    
    var user : User!
    
    @IBOutlet weak var userNameTextUI: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        userNameTextUI.text = user.getEmail()
        
        
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
