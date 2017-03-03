//
//  ViewController.m
//  试验mas
//
//  Created by kingpoint on 15/12/29.
//  Copyright © 2015年 kingpoint. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *sv = [UIView new];
    sv.backgroundColor = [UIColor redColor];
    [self.view addSubview:sv];
    
    UIView *sv1 = [UIView new];
    sv1.backgroundColor = [UIColor greenColor];
    [self.view addSubview:sv1];
    
    [sv mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(@20);
//        make.top.equalTo(@20);
        make.size.mas_equalTo(CGSizeMake(300, 300));
    }];
    
    [sv1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sv.mas_top).offset(20);
        make.left.equalTo(sv.mas_left).offset(20);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
