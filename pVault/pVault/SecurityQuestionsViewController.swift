//
//  SecurityQuestionsViewController.swift
//  pVault
//
//  Created by Joseph ORLANDO on 11/20/14.
//  Copyright (c) 2014 Pvault2. All rights reserved.
//

import UIKit

class SecurityQuestionsViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate, UITextFieldDelegate  {

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

    
    
    //Called before Seque is taken
    override func prepareForSegue(segue : UIStoryboardSegue, sender: AnyObject?) {
    
        //This is not an ideal solution but works
        goingBack = false
        
        //Mylabel represent current question
        SecurityQuestions.selectQuestion(myLabel.text!)
        
        SecurityQuestions.userAnswers.append(answer.text!)
        
        RegisterInfo.answers = SecurityQuestions.userAnswers
        
        RegisterInfo.questions = SecurityQuestions.selectedQuestions
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        if (goingBack)
        {
            
            //
            
            if ( !SecurityQuestions.previousQuestion.isEmpty)
            {
                SecurityQuestions.unselectQuestion(SecurityQuestions.previousQuestion.removeLast())
                
            }
            
            //If Empty skip because they are on Question 1 and want to go back to password screen
            if ( !SecurityQuestions.userAnswers.isEmpty)
            {
                //When going back to prev question, remove its answer
                SecurityQuestions.userAnswers.removeLast()
            }
            
        }
        else {
            
            goingBack = true
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.answer.delegate = self;
        
        myPicker.delegate = self
        myPicker.dataSource = self

        myLabel.text = SecurityQuestions.questionBank[0]
        
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
        return SecurityQuestions.questionBank.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return SecurityQuestions.questionBank[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        myLabel.text = SecurityQuestions.questionBank[row]
    }

    
    //hides the keyboard when you hit return
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        
        self.view.endEditing(true);
        return false;
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
