//
//  SecurityQuestionAnswerViewController.swift
//  pVault
//
//  Created by Joseph ORLANDO on 12/10/14.
//  Copyright (c) 2014 Pvault2. All rights reserved.
//

import UIKit

class SecurityQuestionAnswerViewController: UIViewController {

    @IBOutlet weak var questionLabelOne: UILabel!
    @IBOutlet weak var questionLabel2: UILabel!
    @IBOutlet weak var questionLabel3: UILabel!
    
    @IBOutlet weak var answer1: UITextField!
    @IBOutlet weak var answer2: UITextField!
    @IBOutlet weak var answer3: UITextField!
    
    @IBOutlet weak var warningLabel1: UILabel!
    @IBOutlet weak var warningLabel2: UILabel!
    @IBOutlet weak var warningLabel3: UILabel!
    
    
    enum LabelStatus {
        case Match
        case Dont
        case Empty
    }
    
    func updateWarningLabel( label : UILabel , status : LabelStatus) {
        
        switch(status) {
        case .Match:
            label.text = "Correct"
            label.textColor = UIColor.greenColor()
            break
        case .Dont:
            label.text = "Incorrect"
            label.textColor = UIColor.redColor()
            break
        case .Empty:
            label.text = ""
            break
        }
        
        updateContinue()
    }
    
    @IBAction func answerChanged1(sender: AnyObject) {
        
        var equal = checkQ1()
        
        var status : LabelStatus!
        
        if (answer1.text.isEmpty) {
            status = LabelStatus.Empty
        }
        else {
            status = (equal) ? LabelStatus.Match : LabelStatus.Dont
        }
        
        updateWarningLabel(warningLabel1, status: status)
        
    }
    
    @IBAction func answerChanged2(sender: AnyObject) {
        
        var equal = checkQ2()
        
        var status : LabelStatus!
        
        if (answer2.text.isEmpty)
        {
            status = LabelStatus.Empty
        }
        else {
            status = (equal) ? LabelStatus.Match : LabelStatus.Dont
        }
        
        updateWarningLabel(warningLabel2, status: status)
        
    }
    @IBAction func answerChanged3(sender: AnyObject) {
        
        var equal = checkQ3()
        
        var status : LabelStatus!
        
        if(answer3.text.isEmpty) {
            status = LabelStatus.Empty
        }
        else {
            status = (equal) ? LabelStatus.Match : LabelStatus.Dont
        }
        
        updateWarningLabel(warningLabel3, status: status)
        
    }
    
    func updateContinue() {
        if (checkQ1() && checkQ2() && checkQ3())
        {
            continueButton.enabled = true
            continueButton.alpha = 1
        }
        else {
            continueButton.enabled = false
            continueButton.alpha = 0.4
        }
    }
    
    
    @IBOutlet weak var continueButton: UIButton!
    
    var securityQuestions: [String:String]!
    var questions : [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        continueButton.enabled = false
        continueButton.alpha = 0.4
        
        //Makes the array of the questions
        questions = Array(securityQuestions.keys)
        populateFields()
        
    }
    
    
    func checkQ1() -> Bool {
        return securityQuestions[questionLabelOne.text!] == answer1.text!
    }

    func checkQ2() -> Bool{
        return securityQuestions[questionLabel2.text!] == answer2.text!
    }
    
    func checkQ3() -> Bool {
        return securityQuestions[questionLabel3.text!] == answer3.text!
    }
    
    
    func populateFields() {
        
        //Set the Text Fields
        questionLabelOne.text = questions[0]
        questionLabel2.text = questions[1]
        questionLabel3.text = questions[2]
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
