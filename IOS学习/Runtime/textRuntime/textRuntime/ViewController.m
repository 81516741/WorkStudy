//
//  ViewController.m
//  textRuntime
//
//  Created by kingpoint on 15/12/25.
//  Copyright © 2015年 kingpoint. All rights reserved.
//

#import "ViewController.h"
#import "RuntimeItem.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    RuntimeItem * item =[RuntimeItem new];
    item.name = @"fda";
    item.age = @"22";
    [item getAll];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
