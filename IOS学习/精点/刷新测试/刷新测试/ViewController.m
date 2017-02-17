//
//  ViewController.m
//  刷新测试
//
//  Created by kingpoint on 15-12-15.
//  Copyright (c) 2015年 kingpoint. All rights reserved.
//

#import "ViewController.h"
#import "MJRefresh.h"
#import "GMActivityView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView addHeaderWithCallback:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView headerEndRefreshing];
        });
    }];
    

//
//    GMActivityView * active = [[GMActivityView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
//    self.tableView.tableHeaderView = active;
//    [active startAnimation];
    
}



@end
