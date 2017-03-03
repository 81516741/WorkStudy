//
//  ViewController.m
//  检查网络状态
//
//  Created by ld on 16/10/24.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "ViewController.h"
#import "Reachability.h"
@interface ViewController ()

@property (nonatomic,strong) Reachability * reachability;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self checkNetState];
}


-(void)checkNetState
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(netStateChange:) name:kReachabilityChangedNotification object:nil];
    
    _reachability = [Reachability reachabilityForInternetConnection];
    [_reachability startNotifier];
}

-(void)netStateChange:(NSNotification *)noti
{
    NSLog(@"df");
}

@end
