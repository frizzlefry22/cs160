//
//  SecurityQuestionsViewController.swift
//  pVault
//
//  Created by Joseph ORLANDO on 11/20/14.
//  Copyright (c) 2014 Pvault2. All rights reserved.
//

import UIKit

class SecurityQuestionsViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {

    //VIEW STUFF
    
    @IBOutlet weak var myLabel: UILabel!
    
    @IBOutlet weak var continueButton: UIButton!
    
    @IBOutlet weak var myPicker: UIPickerView!
    
    @IBOutlet weak var segControl: UISegmentedControl!
    
    @IBOutlet weak var answer: UITextField!
    
    @IBAction func answerEdited(sender: AnyObject) {
        continueButton.enabled = !answer.text.isEmpty
    }
    
    //Vars
    var goingBack = true
    //var currentQuestion : String
    
    var answers = [String]()
      
    var currentQuestion = (0,"");
    
    var securityQuestions = [ Int : (String,String) ]()
    
    
    
    //Called before Seque is taken
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        //This is not an ideal solution but works
        goingBack = false
        
        //securityQuestions[currentQuestion.0] = ("","")
        
        //Mylabel represent current question
        selectQuestion(myLabel.text!)
        
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        if (goingBack)
        {
            unselectQuestion(previousQuestion.removeLast())
        }
        else {
            
            goingBack = true
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myPicker.delegate = self
        myPicker.dataSource = self

        myLabel.text = questionBank[0]
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    //The number of components is 1, 1 question per row
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return questionBank.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return questionBank[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        myLabel.text = questionBank[row]
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
