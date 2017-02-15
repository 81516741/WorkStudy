//
//  DecoraterBase.m
//  3-装饰者模式
//
//  Created by ld on 16/11/29.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "DecoraterBase.h"

@implementation DecoraterBase
+(DecoraterBase *)decorate:(OriginComponent *)originObject
{
    DecoraterBase * object = [[self alloc]init];
    object.originObject = originObject;
    object.size = originObject.size;
    object.isDecorate = true;
    return object;
}

+(DecoraterBase *)moveDecorate:(OriginComponent *)originObject
{
    DecoraterBase * object = [[self alloc]init];
    object.originObject = originObject;
    object.size = originObject.size;
    object.isDecorate = false;
    return object;
}




@end
