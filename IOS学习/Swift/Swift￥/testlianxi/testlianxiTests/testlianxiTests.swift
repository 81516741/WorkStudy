//
//  testlianxiTests.swift
//  testlianxiTests
//
//  Created by ld on 16/4/9.
//  Copyright © 2016年 ld. All rights reserved.
//

import XCTest
@testable import testlianxi

class testlianxiTests: XCTestCase {
    var vc :ViewController!
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
       let st = UIStoryboard.init(name: "Main", bundle: NSBundle.mainBundle())
        vc = st.instantiateViewControllerWithIdentifier("ViewController") as!ViewController
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPrint(){
       let temp = vc.printSomeThing(4)
        XCTAssert(temp == 4)
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
