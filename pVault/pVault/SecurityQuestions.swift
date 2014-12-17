//
//  SecurityQuestions.swift
//  pVault
//
//  Created by Joseph ORLANDO on 11/23/14.
//  Copyright (c) 2014 Pvault2. All rights reserved.
//

import Foundation


//Put everything in a Struct to clean up in the rest of the project
//Now you access stuff with SecurityQuestions.property or function
struct SecurityQuestions {
    
    static var questionBank : [String]!
    
    static let questionSource = ["What city were you born?", "Who is your favorite  Professor?", "Your first Pets name?", "Favorite Sport?", "First car"]
    
    static func resetQuestionBank() {
        questionBank = questionSource
    }
    
    
    static var selectedQuestions = [String]()
    
    //String array so that it can remember back 2 times
    static var previousQuestion = [String]()
    
    
    //
    static var userAnswers = [String]()
    
    /*
    Function to select question
    Removes it from Bank and adds to selected array
    */
    static func selectQuestion(str : String) {
        let removed = removeString(str,  &SecurityQuestions.questionBank!)
        selectedQuestions.append(removed)
        previousQuestion.append(str)
    }
    
    /*
    Function to deselect a question
    Removes form selected and adds back to bank
    */
    static func unselectQuestion( str : String ) {
        addString(str,  &SecurityQuestions.questionBank!)
        
        //Sorts them so that they match the UIPicker
        SecurityQuestions.questionBank = sorted(SecurityQuestions.questionBank)
        
        removeString(str, &selectedQuestions)
    }
}

