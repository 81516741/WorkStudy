//
//  SoundArrObject.m
//  设计模式之--1.小鸭子
//
//  Created by ld on 16/11/28.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "SoundArrObject.h"

@implementation SoundBark

-(void)sound
{
    NSLog(@"bark");
}

-(void)niaoniao
{
    NSLog(@"尿尿声");
}

@end

@implementation SoundMute

-(void)sound
{
    NSLog(@"mute");
}

-(void)niaoniao
{
    NSLog(@"没有尿意");
}

@end
