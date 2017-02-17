//
//  ViewController.m
//  画波纹实验
//
//  Created by mac on 15/12/27.
//  Copyright © 2015年 LD. All rights reserved.
//

#import "ViewController.h"
#import "WaveView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:[[WaveView alloc]initWithFrame:self.view.bounds]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
