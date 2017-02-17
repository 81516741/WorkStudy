//
//  ViewController.m
//  链式编程
//
//  Created by mac on 16/2/20.
//  Copyright © 2016年 LD. All rights reserved.
//

#import "ViewController.h"
#import "UIView+LDViewLine.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView * view = [UIView setView:^(UIView *make) {
        make.set([NSValue valueWithCGRect:CGRectMake(100, 100, 100, 100)]).set([UIColor redColor]);
    }];
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
