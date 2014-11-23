//
//  SecurityQuestions.swift
//  pVault
//
//  Created by Joseph ORLANDO on 11/23/14.
//  Copyright (c) 2014 Pvault2. All rights reserved.
//

import Foundation

var questionBank = ["Question 1","Question 2","Question 3","Question 4","Question 5"]

var previousQuestion = ""

//Initialize String Array
var selectedQuestions = [String]()

//Removes String from Array arrr
func removeString ( str : String , inout arrr : [String] ) -> String{
    
    let ind = find(arrr,str)
    return arrr.removeAtIndex(ind!)
}

//Adds String to aray arrr
func addString( str : String, inout arrr : [String] ) {
    arrr.append(str)
}

/*
Function to select question
Removes it from Bank and adds to selected array
*/
func selectQuestion(str : String) {
    let removed = removeString(str,  &questionBank)
    selectedQuestions.append(removed)
    previousQuestion = str
}

/*
Function to deselect a question
Removes form selected and adds back to bank
*/
func unselectQuestion( str : String ) {
    addString(str,  &questionBank)
    removeString(str, &selectedQuestions)
}
