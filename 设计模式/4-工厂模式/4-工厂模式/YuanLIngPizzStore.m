//
//  YuanLIngPizzStore.m
//  4-工厂模式
//
//  Created by ld on 16/11/29.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "YuanLIngPizzStore.h"
#import "YuanLingPizz.h"
#import "YuanLingCaiLiao.h"
@implementation YuanLIngPizzStore
+(PizzBase *)makePizz
{
    return [YuanLingPizz pizz:[YuanLingCaiLiao new]];
}
@end
