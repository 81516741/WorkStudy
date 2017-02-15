//
//  PizzBase.h
//  4-工厂模式
//
//  Created by ld on 16/11/29.
//  Copyright © 2016年 ld. All rights reserved.

//这个类定义了具体pizz的口味风格的接口 --具体口味在子类中做
#import <Foundation/Foundation.h>
#import "CaiLiaoBase.h"
@interface PizzBase : NSObject
@property (nonatomic,copy) NSString * name;
@property (nonatomic,copy) NSString * price;
@property (nonatomic,strong) CaiLiaoBase * cailiao;
//原材料
@property (nonatomic,copy) NSString * lajiao;
@property (nonatomic,copy) NSString * dasuan;
//pizz的一系列加工处理，这里就列两个
-(void)prepare;
-(void)bake;
-(void)cute;
+(PizzBase *)pizz:(CaiLiaoBase *)cailiao;
@end
