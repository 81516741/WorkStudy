//
//  PizzStore.m
//  4-工厂模式
//
//  Created by ld on 16/11/29.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "PizzStore.h"
@implementation PizzStore

+(PizzBase *)orderPizz
{
    PizzBase * pizz = [self makePizz];
    [pizz prepare];
    [pizz bake];
    [pizz cute];
    return pizz;
}

+(PizzBase *)makePizz
{
    return nil;
}
@end
