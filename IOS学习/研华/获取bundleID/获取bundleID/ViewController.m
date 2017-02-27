//
//  ViewController.m
//  获取bundleID
//
//  Created by yh on 16/5/26.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   NSString * bundleID =  [[[NSBundle mainBundle]infoDictionary]valueForKey:@"CFBundleIdentifier"];
    NSLog(@"%@",bundleID);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
