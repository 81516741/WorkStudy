//
//  NSObject+KVO.m
//  响应式编程
//
//  Created by mac on 16/2/20.
//  Copyright © 2016年 LD. All rights reserved.
//

#import "NSObject+KVO.h"
#import "LDKVONotification_Person.h"
#import <objc/runtime.h>
@implementation NSObject (KVO)

-(void)ld_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context
{
    //动态创建person的子类，这里直接手动创建
    
    //修改isa指针
    object_setClass(self, [LDKVONotification_Person class]);
    //保存observe
    objc_setAssociatedObject(self, @"observer", observer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

@end
