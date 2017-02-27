//
//  ViewController.m
//  fadsf
//
//  Created by yh on 16/4/25.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    id arr = @[@"234"];
    @try {
        arr[3];
    } @catch (NSException *exception) {
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
