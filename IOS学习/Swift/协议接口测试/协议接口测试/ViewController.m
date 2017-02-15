//
//  ViewController.m
//  协议接口测试
//
//  Created by yh on 16/4/11.
//  Copyright © 2016年 yh. All rights reserved.
//

#import "ViewController.h"
#import "Model.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    Model * model = [Model new];
    [model sendMessage];
}

@end
