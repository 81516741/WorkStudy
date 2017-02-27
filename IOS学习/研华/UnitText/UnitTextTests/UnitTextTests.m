//
//  UnitTextTests.m
//  UnitTextTests
//
//  Created by yh on 16/8/3.
//  Copyright © 2016年 ld. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface UnitTextTests : XCTestCase

@end

@implementation UnitTextTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    //设置变量和设置预期值
    NSUInteger a = 10;
    NSUInteger b = 15;
    NSUInteger expected = 25;
    //执行方法得到实际值
    NSUInteger actual = [self add:a b:b];
    //断言判定实际值和预期是否符合
    XCTAssertEqual(expected, actual,@"add方法错误！");
}

-(NSInteger)add:(NSInteger)a b:(NSInteger)b
{
    return a + b;
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
