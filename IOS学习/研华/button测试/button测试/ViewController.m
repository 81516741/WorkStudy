//
//  ViewController.m
//  button测试
//
//  Created by yh on 16/5/11.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "ViewController.h"
#import "LDButton.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    LDButton * btn = [LDButton new];
    [btn setImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
    [btn setTitle:@"123456" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn sizeToFit];
    btn.frame = CGRectMake(100, 100, 100, 100);;
    [self.view addSubview: btn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
