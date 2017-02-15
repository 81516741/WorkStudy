//
//  Duck.h
//  设计模式之--1.小鸭子
//
//  Created by ld on 16/11/28.
//  Copyright © 2016年 ld. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SoundArrObject.h"
#import "FlyArrObject.h"


@interface Duck : NSObject

@property (nonatomic,strong) id<SoundArrOnjectInterface> soundArrObject;
@property (nonatomic,strong) id<FlyArrObjectInterface> flyArrObject;

//一系列行为
-(void)perFormMakeSound;
-(void)perFormFly;
//改变类族的方法
-(void)changeFlyModel:(id<FlyArrObjectInterface>) flyModel;
-(void)changeSoundModel:(id<SoundArrOnjectInterface>) soundModel;

@end
