//
//  SoundArrObject.h
//  设计模式之--1.小鸭子
//
//  Created by ld on 16/11/28.
//  Copyright © 2016年 ld. All rights reserved.
//

#import <Foundation/Foundation.h>

//接口
@protocol SoundArrOnjectInterface <NSObject>
-(void)sound;
-(void)niaoniao;
@end

@interface SoundBark : NSObject<SoundArrOnjectInterface>

@end

@interface SoundMute : NSObject<SoundArrOnjectInterface>

@end
