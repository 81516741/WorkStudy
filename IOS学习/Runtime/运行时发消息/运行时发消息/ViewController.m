//
//  ViewController.m
//  运行时发消息
//
//  Created by Kingpoint on 16/1/14.
//  Copyright © 2016年 kingpoint. All rights reserved.
//

#import "ViewController.h"
#import <objc/message.h>
#import "HYBCat.h"
#import "HYBDog.h"
#import "HYBPig.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView * selfView = self.view;
    //创建view
    UIView * redView = ((UIView * (*)(id,SEL))objc_msgSend)((id)[UIView class],@selector(new));
    //设置view的背景
    ((void (*)(id,SEL,UIColor *))objc_msgSend)((id)redView,@selector(setBackgroundColor:), [UIColor redColor]);
    //添加view
    ((void(*)(id,SEL,UIView *))objc_msgSend)((id)selfView,@selector(addSubview:),redView);
    //设置view的frame
    ((void(*)(id,SEL,CGRect))objc_msgSend)((id)redView,@selector(setFrame:),selfView.bounds);
    
    [HYBCat test];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
