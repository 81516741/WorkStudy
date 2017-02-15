//
//  ViewController.m
//  发消息应用
//
//  Created by mac on 16/1/16.
//  Copyright © 2016年 LD. All rights reserved.
//

#import "ViewController.h"
#import "LDView.h"
#import "LDImageView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    LDView * view = [[LDView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    [self.view addSubview:view];
    view.backgroundColor = [UIColor yellowColor];
    [view addTarget:self sel:@selector(click:)];
    
    
    LDImageView * imageView = [[LDImageView alloc]initWithFrame:CGRectMake(100, 220, 100, 100)];
    [self.view addSubview:imageView];
    imageView.backgroundColor = [UIColor redColor];
    [imageView addTarget:self sel:@selector(click:)];
}

-(void)click:(UIView *)view
{
    NSLog(@"%@------",view);
    
}

@end
