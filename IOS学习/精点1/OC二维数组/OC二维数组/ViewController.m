//
//  ViewController.m
//  OC二维数组
//
//  Created by ld on 16/9/6.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "ViewController.h"

typedef NSMutableArray<NSMutableArray<NSNumber *> *> MyTwoArray;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    MyTwoArray * arr = @[].mutableCopy;
    NSMutableArray<NSNumber *> * arr1 = @[@1,@2,@3].mutableCopy;
    arr[0] = arr1;
    arr[1] = [arr1 arrayByAddingObject:@8].mutableCopy;
    NSLog(@"%@",arr[1][1]);
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
