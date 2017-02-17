//
//  SingleObj.m
//  播放音乐
//
//  Created by yh on 16/4/28.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "SingleObj.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface SingleObj ()
{
    AVAudioPlayer * _player;
}



@end
@implementation SingleObj


-(void)play
{
    NSString * musicFilePath = [[NSBundle mainBundle] pathForResource:@"messageTipVoice" ofType:@"wav"];      //创建音乐文件路径
    NSURL * musicURL= [[NSURL alloc] initFileURLWithPath:musicFilePath];
    
    AVAudioPlayer * thePlayer  = [[AVAudioPlayer alloc] initWithContentsOfURL:musicURL error:nil];
    //创建播放器
    _player = thePlayer;    //赋值给自己定义的类变量
    
    
    [_player setVolume:1];   //设置音量大小0-1之间
    //    _player.numberOfLoops = 0;//设置音乐播放次数  -1为一直循环
    
    [_player play];   //播放
    AudioSessionSetActive (true);
    NSLog(@"放");
}

#pragma - mark 单例

static id _instace;

+ (id)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instace = [super allocWithZone:zone];
    });
    return _instace;
}

+ (instancetype)shared
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instace = [[self alloc] init];
    });
    return _instace;
}

- (id)copyWithZone:(NSZone *)zone
{
    return _instace;
}
@end
