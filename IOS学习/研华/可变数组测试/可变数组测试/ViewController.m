//
//  ViewController.m
//  可变数组测试
//
//  Created by yh on 16/3/28.
//  Copyright © 2016年 yh. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableArray * arr = [NSMutableArray array];
    [arr addObject:@"fad"];
    [arr setObject:@"aaaa" atIndexedSubscript:0];
    arr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
