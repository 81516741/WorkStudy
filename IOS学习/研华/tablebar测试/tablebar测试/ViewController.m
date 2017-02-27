//
//  ViewController.m
//  tablebar测试
//
//  Created by yh on 16/3/29.
//  Copyright © 2016年 yh. All rights reserved.
//

#import "ViewController.h"
#import "UITabBar+KDTabBarBadge.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.tabBarController.tabBar showBadgeOnItemIndex:1];
}

@end
