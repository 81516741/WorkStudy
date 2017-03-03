//
//  ViewController.m
//  流量球
//
//  Created by ld on 16/12/1.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "ViewController.h"
#import "WaterBallView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    WaterBallView * views = [[WaterBallView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    views.progress = 0.5;
    [self.view addSubview:views];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
