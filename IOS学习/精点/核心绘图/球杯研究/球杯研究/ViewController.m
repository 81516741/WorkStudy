//
//  ViewController.m
//  球杯研究
//
//  Created by mac on 15/12/27.
//  Copyright © 2015年 LD. All rights reserved.
//

#import "ViewController.h"
#import "FlowProgressView.h"
@interface ViewController ()
@property(nonatomic, strong) FlowProgressView  * fview;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.fview = [[FlowProgressView alloc]initWithFrame:CGRectMake(50, 50, 100, 100)];
    
    [_fview setProgress:0.7 flowLevel:Flow_Level_Ample];
//    _fview.layer.cornerRadius = 50;
//    _fview.layer.masksToBounds = YES;

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.fview stopAnimation];
    });
    [self.view addSubview:_fview];
  
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
