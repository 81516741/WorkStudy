//
//  octextlianxiTests.m
//  octextlianxiTests
//
//  Created by ld on 16/4/9.
//  Copyright © 2016年 ld. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ViewController.h"
@interface octextlianxiTests : XCTestCase
{
    ViewController * vc;
}
@end

@implementation octextlianxiTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    UIStoryboard * st =[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    vc = [st instantiateViewControllerWithIdentifier:@"mainmain"];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testPrint
{
//    NSInteger temp = [vc printSome:4];
//    XCTAssert(temp == 3);
    ViewController * viewVC = [ViewController new];
    NSInteger textNum = [viewVC printSome:5];
    XCTAssert(textNum == 5);
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
