//
//  LDKVONotification_Person.m
//  响应式编程
//
//  Created by mac on 16/2/20.
//  Copyright © 2016年 LD. All rights reserved.
//

#import "LDKVONotification_Person.h"
#import <objc/runtime.h>
@implementation LDKVONotification_Person

-(void)setAge:(int)age
{
    [super setAge:age];
    //拿到观察者
    id observer = objc_getAssociatedObject(self, @"observer");
    //一旦调用set 方法就调用下面的方法
    [observer observeValueForKeyPath:@"age" ofObject:self change:nil context:nil];
    
}

@end
