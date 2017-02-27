//
//  ViewController.m
//  静音测试
//
//  Created by yh on 16/4/27.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "ViewController.h"
#import "RBDMuteSwitch.h"
#import <AudioToolbox/AudioToolbox.h>

@interface ViewController ()<RBDMuteSwitchDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self beginDetection];
}
#pragma mark Timer methods
- (void)beginDetection {
    [[RBDMuteSwitch sharedInstance] setDelegate:self];
    [[RBDMuteSwitch sharedInstance] detectMuteSwitch];
}


#pragma mark RBDMuteSwitchDelegate methods
- (void)isMuted:(BOOL)muted {
    if (muted) {
        NSLog(@"muted");
    }
    else {
        NSLog(@"not muted");
    }
}

@end
