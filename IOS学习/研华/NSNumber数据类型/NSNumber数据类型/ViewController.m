//
//  ViewController.m
//  NSNumber数据类型
//
//  Created by yh on 16/4/15.
//  Copyright © 2016年 yh. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSNumber * number = [[NSNumber alloc]initWithShort:(short)1];
    if (strcmp([number objCType], @encode(short)) == 0){
        NSLog(@"shor");
    }else if (strcmp([number objCType], @encode(int)) == 0){
        NSLog(@"int");
    }else if (strcmp([number objCType], @encode(long)) == 0){
        NSLog(@"long");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
