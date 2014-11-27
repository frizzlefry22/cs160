// Playground - noun: a place where people can play

import UIKit


var questionBank = ["Question 1", "Question 2", "Question 3","Question 4",  "Question 5"]

//func getIndex ( str : String) -> Int {
    
//    var toReturn = -1 //Not Found
    
 //   for (key,value) in questionBank {
        
   //     if(value == str) {
          //  toReturn = key // Found
     //   }
   // }
    
    //return toReturn//
//}

//var ind = getIndex("Question 2")

//var ind2 = getIndex("Question 4")

questionBank = sorted(questionBank)


//questionBank.removeValueForKey(1)

questionBank.removeAtIndex(2)

//questionBank[1] = "Question 1"

questionBank


questionBank.append("Question 3")

questionBank = sorted(questionBank)
