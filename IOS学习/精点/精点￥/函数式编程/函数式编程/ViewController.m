//
//  ViewController.m
//  函数式编程
//
//  Created by mac on 16/2/21.
//  Copyright © 2016年 LD. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Set.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView * view = [UIView set:^UIView *(UIView *view) {
        view.frame = CGRectMake(100, 100, 100, 200);
        view.backgroundColor = [UIColor redColor];
        return view;
    }];
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
