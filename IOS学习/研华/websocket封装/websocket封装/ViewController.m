//
//  ViewController.m
//  websocket封装
//
//  Created by yh on 16/4/22.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "ViewController.h"
#import "YHHTTPModel.h"
#import "MD5Util.h"
#import "YHHTTPManage.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    YHHTTPModel *msgLogin = [YHHTTPModel new];
    msgLogin.taskTag = 0x12345678;
    msgLogin.httpType = YHHTTPTypeWebSocket;
    Byte type = 0x01;
    NSData *typeData = [NSData dataWithBytes:&type length:sizeof(type)];
    // 密码经过MD5加密后上传服务器
    NSString *md5after = [@"123456" stringFromMD5];
    // 密码后面加个设备标识码
    NSString *identifierStr = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    msgLogin.parameters = @[typeData,@"18688733264",md5after,identifierStr];
    [[YHHTTPManage shared]sendMessage:msgLogin success:^(YHHTTPModel *model) {
        
    } failure:^(YHHTTPModel *model) {
        
    }];

}

@end
