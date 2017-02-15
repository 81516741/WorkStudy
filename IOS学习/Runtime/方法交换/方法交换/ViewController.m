//
//  ViewController.m
//  方法交换
//
//  Created by mac on 16/1/3.
//  Copyright © 2016年 LD. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self hit];
    
}

+(void)load{
    //注意class_getInstanceMethod 和 class_getClassMethod 一个是类方法一个是对象方法
    method_exchangeImplementations(class_getInstanceMethod([self class], @selector(hit)), class_getInstanceMethod([self class], @selector(kill)));
}
- (void)hit
{
    NSLog(@"hit");
}

- (void)kill{
    NSLog(@"kill");
}
@end
