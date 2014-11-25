//
//  UtilsTests.swift
//  pVault
//
//  Created by Joseph ORLANDO on 11/24/14.
//  Copyright (c) 2014 Pvault2. All rights reserved.
//

//import Cocoa
import XCTest

class UtilsTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRemoveString() {
       
        var strArr = ["a","b","cd","e"]
        
        removeString("cd", &strArr)
        
        XCTAssertEqual(strArr, ["a","b","e"], "Shuold remove cd")
        
    }

    func testAddString() {
        var str = []
    }
    
    

}
