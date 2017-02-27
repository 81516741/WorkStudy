//
//  NSObject+dealloc.m
//  weak属性runtime实现
//
//  Created by ld on 17/2/17.
//  Copyright © 2017年 ld. All rights reserved.
//

#import "NSObject+dealloc.h"
#import <objc/runtime.h>
@implementation NSObject (dealloc)

-(void)dealloc:(dispatch_block_t)block
{
    LDObject * object = [[LDObject alloc]initWithBlock:block];
    objc_setAssociatedObject(self, _cmd, object, OBJC_ASSOCIATION_RETAIN);
}


@end

@implementation LDObject

-(instancetype)initWithBlock:(dispatch_block_t)block
{
    if (self = [super init]) {
        _deallocBlock = [block copy];
    }
    return self;
}

-(void)dealloc
{
    _deallocBlock ? _deallocBlock() : nil;
}

@end
