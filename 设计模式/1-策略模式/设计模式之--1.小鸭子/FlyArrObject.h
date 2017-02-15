//
//  FlyArrObject.h
//  设计模式之--1.小鸭子
//
//  Created by ld on 16/11/28.
//  Copyright © 2016年 ld. All rights reserved.
//

#import <Foundation/Foundation.h>
//接口
@protocol FlyArrObjectInterface <NSObject>
-(void)fly;
@end

@interface FlyRocket : NSObject<FlyArrObjectInterface>

@end

@interface FlyNoFly : NSObject<FlyArrObjectInterface>

@end
