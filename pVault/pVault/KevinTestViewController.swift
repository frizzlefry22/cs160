//
//  KevinTestViewController.swift
//  pVault
//
//  Created by Kevin Tran on 12/4/14.
//  Copyright (c) 2014 Pvault2. All rights reserved.
//

import UIKit

class KevinTestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func getImage(sender: AnyObject) {
        var temp : Document = DocumentDBConnection.read(DocumentDBConnection.readObject("z5MfCXikMC")) as Document
        
        imagePreview.image = Encoder.decodeImage(temp.docImage) //temp.docImage//
    }

    @IBOutlet weak var imagePreview: UIImageView!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
