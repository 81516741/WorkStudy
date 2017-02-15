//
//  DuckWing.m
//  设计模式之--1.小鸭子
//
//  Created by ld on 16/11/28.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "DuckWing.h"

@implementation DuckWing
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.flyArrObject = [FlyRocket new];
        self.soundArrObject = [SoundBark new];
    }
    return self;
}

@end
