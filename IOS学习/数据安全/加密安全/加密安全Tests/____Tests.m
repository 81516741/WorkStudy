//
//  ____Tests.m
//  加密安全Tests
//
//  Created by ld on 17/2/17.
//  Copyright © 2017年 ld. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DigitalTool.h"

@interface ____Tests : XCTestCase

@end

@implementation ____Tests

- (void)setUp {
    [super setUp];
    // Put setup
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}
- (void)testAES
{
    // 字典转换成Json字符串
    NSDictionary * testDict = @{@"hid":@"1",
                                @"cut_price":@"2",
                                @"cut_num":@"3",
                                @"goods_id":@"4",
                                @"pool_id":@"5"};
    NSData * keyData = [DigitalTool randomDataWithLength:7];
    NSString * keyString = [DigitalTool hexStringFromData:keyData];
    NSData * data1 = [testDict AESEncryptWithKey:keyString];
    NSDictionary * dic = [data1 AESDecryptWithKey:keyString];
    data1 = [dic AESEncryptWithKey:keyData];
    dic = [data1 AESDecryptWithKey:keyData];
    NSAssert(dic != nil, @"");
}

- (void)testExample
{
    NSString * publicKey = @"942d7e7343bf64944b4313b6c1003a7199f4bd432084489b349e1aa6a23c75e3295a44f4d02ce7ccf9cb584336e05a322f0fd2b4ee47f897845874df3eac0d274de55698acf5bfcb625a684187347a788553f2b4c58f1221c3881dd177a5d12f819218f4727e6b01e8cbb4c1a47fe6ec3b3ca07fda426d841926d5ab6fef5043";
    NSString * privateKey = @"3c70c21f6a06eb93c18f3ebf50c233149b63c4bf58c81c859254db321502ec63183f05d986008b1c84d778cd11d9397136d9116d53b46fa5fe09c6c238e21d0ac82a8fcaa323f077db5e886fd6e4ddb7d9012c6681a956ea122e37f0c44c02a8a148352f7153076de8a5a349c1a5622542656f5e7b128be45b970050a2d3d3c1";
    NSDictionary * dic = @{@"hid":@"的房间爱上打开附件是来",
                           @"cut_price":@"2",
                           @"cut_num":@"3",
                           @"goods_id":@"4",
                           @"pool_id":@"5"};
    NSData * originData = [DigitalTool convertDicToData:dic error:nil];
    NSString * originString = [DigitalTool convertDicToString:dic error:nil];
    NSData * encryptData = [originData RSAEncryptWithPublicKey:publicKey];
    
    NSData * decryptdata = [encryptData RSADecryptWithPublicKey:publicKey privateKey:privateKey];
    NSString * decryptString = [DigitalTool convertDataToString:decryptdata];
    NSAssert([decryptString isEqualToString:originString], @"不对");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
        for (int i = 0; i < 100; i ++) {
            NSLog(@"%d",i);
        }
    }];
}

@end
