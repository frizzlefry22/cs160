//
//  ViewImageViewController.swift
//  pVault
//
//  Created by Kevin Tran on 12/12/14.
//  Copyright (c) 2014 Pvault2. All rights reserved.
//

import UIKit

class ViewImageViewController: UIViewController, DocumentView {

    //documentView protocol
    var document: Document!
    
    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        image.image = Encoder.decodeImage(document.docImage)
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
