//
//  main.m
//  kvo底层实现
//
//  Created by ld on 16/11/28.
//  Copyright © 2016年 ld. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
@interface TestClass1 : NSObject
@property (assign ,nonatomic) NSInteger x;
@end

@implementation TestClass1
@end


@interface TestClass : NSObject
@property (assign ,nonatomic) int x;
@property (assign ,nonatomic) int y;
@property (assign ,nonatomic) int z;
@end

@implementation TestClass
@end

static NSArray *ClassMethodNames(Class c)
{
    NSMutableArray *array = [NSMutableArray array];
    
    unsigned int methodCount = 0;
    Method *methodList = class_copyMethodList(c, &methodCount);
    unsigned int i;
    for(i = 0; i < methodCount; i++)
        [array addObject: NSStringFromSelector(method_getName(methodList[i]))];
    free(methodList);
    
    return array;
}

static void PrintDescription(NSString *name, id obj)
{
    NSString *str = [NSString stringWithFormat:
                     @"%@: %@\n\t 编译类型 %s\n\t 真实类型 %s\n\t 该真实类的所有方法 <%@>",
                     name,
                     obj,
                     class_getName([obj class]),
                     class_getName(object_getClass(obj)),
                     [ClassMethodNames(object_getClass(obj)) componentsJoinedByString:@", "]];
    printf("%s\n", [str UTF8String]);
}


int main(int argc, char **argv)
{
    [NSAutoreleasePool new];
    
    TestClass *x = [[TestClass alloc] init];
    TestClass *y = [[TestClass alloc] init];
    TestClass *xy = [[TestClass alloc] init];
    TestClass *control = [[TestClass alloc] init];
    TestClass *controlSame = [[TestClass alloc] init];
    
    [x addObserver:x forKeyPath:@"x" options:0 context:NULL];
    [xy addObserver:xy forKeyPath:@"x" options:0 context:NULL];
    [y addObserver:y forKeyPath:@"y" options:0 context:NULL];
    [xy addObserver:xy forKeyPath:@"y" options:0 context:NULL];
    
    PrintDescription(@"control", control);
    PrintDescription(@"x", x);
    PrintDescription(@"y", y);
    PrintDescription(@"xy", xy);
    
    printf("NSObject提供的方法 获取方法真实地址:\n control setX 方法的地址:    %p,\n normalSame setX 方法的地址: %p,\n 用了kvo的 x setX 方法的地址: %p\n",
           [control methodForSelector:@selector(setX:)],
           [controlSame methodForSelector:@selector(setX:)],
           [x methodForSelector:@selector(setX:)]);
    
    printf("运行时提供的方法 获取方法真实地址:\n control setX 方法的地址:    %p,\n normalSame setX 方法的地址: %p,\n 用了kvo的 x setX 方法的地址: %p\n",
           method_getImplementation(class_getInstanceMethod(object_getClass(control),
                                                            @selector(setX:))),
           method_getImplementation(class_getInstanceMethod(object_getClass(controlSame),
                                                            @selector(setX:))),
           method_getImplementation(class_getInstanceMethod(object_getClass(x),
                                                            @selector(setX:))));
    
    return 0; 
}

