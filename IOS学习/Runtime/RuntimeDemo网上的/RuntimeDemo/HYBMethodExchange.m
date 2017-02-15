//
//  HYBMethodExchange.m
//  RuntimeDemo
//
//  Created by huangyibiao on 16/1/4.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import "HYBMethodExchange.h"
#import <objc/runtime.h>

@interface NSArray (Test)

- (instancetype)__hyb_initWithObjects:(id)firstObj, ...;

@end

@implementation NSArray (Test)



@end

@implementation HYBMethodExchange

+ (void)test {
  Method originalMethod = class_getInstanceMethod([NSArray class], @selector(initWithObjects:count:));
  Method newMethod = class_getInstanceMethod([NSArray class], @selector(__hyb_initWithObjects:count:));
  method_exchangeImplementations(originalMethod, newMethod);
  
}

@end
