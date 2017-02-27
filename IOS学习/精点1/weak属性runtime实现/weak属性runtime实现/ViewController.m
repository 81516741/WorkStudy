//
//  ViewController.m
//  weak属性runtime实现
//
//  Created by ld on 17/2/17.
//  Copyright © 2017年 ld. All rights reserved.
//

#import "ViewController.h"
#import "ViewController1.h"
#import "NSObject+dealloc.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    ViewController1 * vc1 = [ViewController1 new];
    [vc1 dealloc:^{
        NSLog(@"xiaohui");
    }];
    [self.navigationController pushViewController:vc1 animated:YES];
}


@end
