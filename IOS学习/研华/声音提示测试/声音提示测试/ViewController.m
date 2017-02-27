//
//  ViewController.m
//  声音提示测试
//
//  Created by yh on 16/4/27.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "ViewController.h"
#import <AudioToolbox/AudioToolbox.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    AudioServicesPlayAlertSound(1051);
        AudioServicesPlaySystemSound(1312);
//    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

@end
