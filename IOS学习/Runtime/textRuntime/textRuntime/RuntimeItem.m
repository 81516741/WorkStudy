//
//  RuntimeItem.m
//  textRuntime
//
//  Created by kingpoint on 15/12/25.
//  Copyright © 2015年 kingpoint. All rights reserved.
//

#import "RuntimeItem.h"
#import <objc/runtime.h>
@implementation RuntimeItem

-(void)getAll{
    
    unsigned int count = 0;
    Ivar * varList = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i ++) {
        Ivar var = varList[i];
        NSString * name = [NSString stringWithUTF8String:ivar_getName(var)];
        //方法一，获取属性的值
        //去掉下划线
        NSString * key = [name substringFromIndex:1];
        //根据名字获得方法，跳进去看看，有好多好东西，比如用String获取Class
        SEL getSel = NSSelectorFromString(key);
        //这句会报个警告，该方法unknown，可能造成leak
        id property = [self performSelector:getSel withObject:nil];
        
        //方法二，获取属性的值
        //这里和上面的一样,只不过是用kvc获取属性的值，还不用去下划线，更方便
        id property1 = [self valueForKeyPath:name];
        
        NSLog(@"%@,%@,%@",name,property,property1);
    }
    
    
}


@end
