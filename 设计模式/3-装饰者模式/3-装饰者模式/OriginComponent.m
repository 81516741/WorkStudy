//
//  OriginComponent.m
//  3-装饰者模式
//
//  Created by ld on 16/11/29.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "OriginComponent.h"

@implementation OriginComponent

//创建一个基产品，默认是装饰的
+(OriginComponent *)instanceWithSize:(SizeOf)size
{
    OriginComponent * instance = [[self alloc]init];
    instance.size = size;
    instance.isDecorate = true;
    return instance;
}

//工厂，定义了生产流程，需要的部分参数由子类的相应方法去实现
-(NSMutableArray *)getdescriptionArr
{
    NSMutableArray * arr = [self.originObject getdescriptionArr] ? [self.originObject getdescriptionArr] : @[].mutableCopy;
    if (self.isDecorate) {
        [arr addObject:[self getSelfName]];
    }else{
        for (NSInteger i = arr.count - 1; i >= 0; i --) {
            NSString * name = arr[i];
            if ([name isEqualToString:[self getSelfName]]) {
                [arr removeObjectAtIndex:i];
                break;
            }
        }
    }
    return arr;
}

-(CGFloat)cost
{
    NSMutableArray * arr = [self.originObject getdescriptionArr] ? [self.originObject getdescriptionArr] : @[].mutableCopy;
    BOOL hasThisPart = false;
    if (!self.isDecorate){
        for (NSInteger i = arr.count - 1; i >= 0; i --) {
            NSString * name = arr[i];
            if ([name isEqualToString:[self getSelfName]]) {
                hasThisPart = true;
                break;
            }
        }
    }
    if (self.isDecorate) {
        return [self.originObject cost] + [self addPrice];
    }else{
        if (hasThisPart) {
            return [self.originObject cost] - [self addPrice];
        }else{
            return [self.originObject cost];
        }
        
    }
}

//下面的两个方法去子类实现
-(CGFloat)addPrice
{
    return 0;
}
-(NSString *)getSelfName
{
    return @"";
}


//这个方法是用来把数组变成字符串的
-(NSString *)getdescriptionString
{
    NSMutableString * description = [NSMutableString string];
    for (NSString * string in [self getdescriptionArr]) {
        [description appendFormat:@"%@  ",string];
    }
    return description;
}

@end
