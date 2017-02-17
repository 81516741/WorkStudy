//
//  ViewController.m
//  播放音乐
//
//  Created by yh on 16/4/28.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "ViewController.h"
#import "YHTipMusicVC.h"
#import "SingleObj.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "TextVC.h"

@interface ViewController ()
@property(nonatomic,strong) YHTipMusicVC * tipVC;
@end

@implementation ViewController
//-(YHTipMusicVC *)tipVC
//{
//    if (_tipVC == nil) {
//        _tipVC = [YHTipMusicVC new];
//    }
//    return _tipVC;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.delegate = [SingleObj shared];
//    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(play) userInfo:nil repeats:YES];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    [self.delegate performSelector:@selector(viewDidTouch) withObject:nil];
//    [[SingleObj shared]play];
    [self.navigationController pushViewController:[TextVC new] animated:YES];
    
}

//- (void)play {
//    [self.tipVC play];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
