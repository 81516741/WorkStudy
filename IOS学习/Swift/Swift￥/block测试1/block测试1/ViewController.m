//
//  ViewController.m
//  block测试1
//
//  Created by ld on 16/4/23.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "ViewController.h"
typedef void(^blk)();
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    __block int a = 10;
    int *p = &a;
    NSLog(@"%p",&a);
    NSLog(@"%p",&p);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        blk b = ^{
            NSLog(@"%p",&a);
            a = 88;
        };
        b();
    });
    
    blk b = ^{
        NSLog(@"%p",&a);
        a = 77;
    };
    b();
    
    NSLog(@"%d",a);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
