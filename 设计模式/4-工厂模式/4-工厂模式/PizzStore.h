//
//  PizzStore.h
//  4-工厂模式
//
//  Created by ld on 16/11/29.
//  Copyright © 2016年 ld. All rights reserved.

//这个类定义pizz的制作流程
#import <Foundation/Foundation.h>
#import "PizzBase.h"
@interface PizzStore : NSObject

+(PizzBase *)orderPizz;
+(PizzBase *)makePizz;
@end
