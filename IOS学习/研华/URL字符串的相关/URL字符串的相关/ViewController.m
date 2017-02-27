//
//  ViewController.m
//  URL字符串的相关
//
//  Created by yh on 16/5/13.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "ViewController.h"
#import "NSString+Extension.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString * str = @">hahah<\\";
    NSLog(@"%@",str.cachesPath) ;
    NSLog(@"%@",str.tempPath) ;
    NSLog(@"%@",str.linkValue) ;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
