//
//  TempViewController.swift
//  pVault
//
//  Created by Joseph ORLANDO on 11/29/14.
//  Copyright (c) 2014 Pvault2. All rights reserved.
//

import UIKit

class TempViewController: UIViewController, AcceptDataDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    func pictureChosen(image: UIImage) {
        println("Here")
        imageView.image = image
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        var vc = segue.destinationViewController as DocPhotoViewController
        
        vc.delegate = self
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
