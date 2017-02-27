//
//  ViewController.m
//  函数and链式编程
//
//  Created by yh on 16/7/6.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "ViewController.h"
#import "UIView+FunctionLineCompile.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [UIView setView:^UIView *(UIView *view) {
        view.frame = [UIScreen mainScreen].bounds;
        view.backgroundColor = [UIColor redColor];
        [self.view addSubview:view];
        return view;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
