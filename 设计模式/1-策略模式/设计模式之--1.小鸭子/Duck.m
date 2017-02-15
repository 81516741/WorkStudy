//
//  Duck.m
//  设计模式之--1.小鸭子
//
//  Created by ld on 16/11/28.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "Duck.h"

@implementation Duck

-(void)perFormMakeSound
{
    [_soundArrObject sound];
    [_soundArrObject niaoniao];
}

-(void)perFormFly
{
    [_flyArrObject fly];
}


-(void)changeFlyModel:(id<FlyArrObjectInterface>)flyModel
{
    self.flyArrObject = flyModel;
}

-(void)changeSoundModel:(id<SoundArrOnjectInterface>)soundModel
{
    self.soundArrObject = soundModel;
}

@end
