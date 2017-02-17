//
//  ViewController.m
//  Jump
//
//  Created by kingpoint on 15/12/24.
//  Copyright © 2015年 kingpoint. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController



- (IBAction)jump:(UIButton *)sender {
    
    //跳转到BD，按照BD定义好的协议，传参，就可以决定跳到那个界面，告诉BD跳回来的schemes
    if([sender.titleLabel.text isEqualToString:@"跳转BD空间"]){
        NSURL * url = [NSURL URLWithString:@"baidu://login/renotify?qq"];
        [[UIApplication sharedApplication] openURL:url];
        NSLog(@"空间");
    }else if ([sender.titleLabel.text isEqualToString:@"跳转BD登陆"]){
        NSURL * url = [NSURL URLWithString:@"baidu://send/renotify?qq"];
        [[UIApplication sharedApplication] openURL:url];
        NSLog(@"登陆");
    }else if ([sender.titleLabel.text isEqualToString:@"跳转BD"]){
        NSURL * url = [NSURL URLWithString:@"baidu://renotify?qq"];
        [[UIApplication sharedApplication] openURL:url];
        NSLog(@"qq");
    }
}

@end
