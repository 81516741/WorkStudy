//
//  ViewController.m
//  泛型练习
//
//  Created by yh on 16/4/12.
//  Copyright © 2016年 yh. All rights reserved.
//

#import "ViewController.h"
#import "LDPakage.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    LDPakage<NSString *> * bag1 = [LDPakage new];
    LDPakage<NSArray *> * bag2 = [LDPakage new];
    LDPakage<NSMutableArray *> * bag3 = [LDPakage new];
    bag2 = (LDPakage<NSArray *> *)bag1;

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
