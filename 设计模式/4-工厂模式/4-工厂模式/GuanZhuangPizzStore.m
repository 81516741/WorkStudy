//
//  GuanZhuangPizzStore.m
//  4-工厂模式
//
//  Created by ld on 16/11/29.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "GuanZhuangPizzStore.h"
#import "GuanZhuangPizz.h"
#import "GuanZhuangCaiLiao.h"
@implementation GuanZhuangPizzStore

+(PizzBase *)makePizz
{
    return [GuanZhuangPizz pizz:[GuanZhuangCaiLiao new]];
}

@end
