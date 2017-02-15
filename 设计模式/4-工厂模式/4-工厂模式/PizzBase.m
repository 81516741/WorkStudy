//
//  PizzBase.m
//  4-工厂模式
//
//  Created by ld on 16/11/29.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "PizzBase.h"

@implementation PizzBase
-(void)prepare{}
-(void)bake{}
-(void)cute{}
+(PizzBase *)pizz:(CaiLiaoBase *)cailiao
{
    PizzBase * pizz = [self new];
    pizz.cailiao = cailiao;
    return pizz;
}
@end
