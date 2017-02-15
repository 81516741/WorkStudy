//
//  DuckNoWing.m
//  设计模式之--1.小鸭子
//
//  Created by ld on 16/11/28.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "DuckNoWing.h"

@implementation DuckNoWing
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.flyArrObject = [FlyNoFly new];
        self.soundArrObject = [SoundMute new];
    }
    return self;
}

@end
