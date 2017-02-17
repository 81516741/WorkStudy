//
//  ViewController.m
//  keychain练习
//
//  Created by ld on 16/11/4.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "ViewController.h"
#import "SAMKeychain.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //在手机上面才可以存储成功
    BOOL isok = [SAMKeychain setPassword:@"123456" forService:@"passWord" account:@"account"];
    NSString * pass = [SAMKeychain passwordForService:@"passWord" account:@"account"];
    [SAMKeychain deletePasswordForService:@"passWord" account:@"account"];
    
    NSLog(@"%@",pass);
}



@end
