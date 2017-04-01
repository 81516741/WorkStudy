//
//  ViewController.m
//  响应者
//
//  Created by ld on 17/3/6.
//  Copyright © 2017年 ld. All rights reserved.
//

#import "ViewController.h"
#import "Aspects.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIButton * buttonGray = [[UIButton alloc]initWithFrame:CGRectMake(50, 50, 150, 150)];
    buttonGray.backgroundColor = [UIColor grayColor];
    [buttonGray addTarget:self action:@selector(grayClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonGray];
    
    UIButton * buttonRed = [[UIButton alloc]initWithFrame:CGRectMake(50, 50, 120, 120)];
    buttonRed.backgroundColor = [UIColor redColor];
    [buttonRed addTarget:self action:@selector(redClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonRed];
    
    UIButton * buttonBlue = [[UIButton alloc]initWithFrame:CGRectMake(50, 50, 100, 100)];
    buttonBlue.backgroundColor = [UIColor blueColor];
    [buttonBlue addTarget:self action:@selector(blueClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonBlue];
    
    [self aspect_hookSelector:@selector(blueClick) withOptions:AspectPositionInstead usingBlock:^(id<AspectInfo> aspectInfo){
        NSString * string;
        NSInvocation *invocation = aspectInfo.originalInvocation;
        [invocation invoke];
        [invocation getReturnValue:&string];
        NSLog(@"ddddd");
    }error:nil];

}

- (NSString *)blueClick
{
    NSLog(@"%s",__func__);
    return @"nimei";
}
- (void)redClick
{
    NSLog(@"%s",__func__);
}
- (void)grayClick
{
    NSLog(@"%s",__func__);
}

@end
