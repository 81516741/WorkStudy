//
//  ViewController.m
//  runtime动态添加类
//
//  Created by kingpoint on 15/12/25.
//  Copyright © 2015年 kingpoint. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
@interface ViewController ()

@end

@implementation ViewController


-(void)touchesBegan:(UITouch *)touches withEvent:(UIEvent *)event{

    
    //这个字典应该存有类名，和类的一些属性的键值
    NSDictionary * property = @{
                                @"className":@"LDVc",
                                @"name":@"小明",
                                };
    
    //获取类名
    const char * className = [@"LDVc1" cStringUsingEncoding:NSUTF8StringEncoding];
    //根据类名动态获取类
    Class  newClass = objc_getClass(className);
    //若果不存在该类，则创建
    if (!newClass) {
        //指定新类的父类
        Class superClass = [UITableViewController class];
        //创建新类
        newClass = objc_allocateClassPair(superClass, className, 0);
        //注册新类
        objc_registerClassPair(newClass);
    }
    //创建新类的对象
    id new = [newClass new];
    //用kvc给类的属性赋值，赋完值就可以直接push了
    [new setValue:[UIColor greenColor] forKeyPath:@"view.backgroundColor"];
    
    
    //这里主要是判断下该类中是否存在某些属性，这些属性的键值存在字典里面
//    [property enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
//        //遍历对象的属性，如果有该属性就返回YES反之NO
//        if ([self isExistProperty:key inObject:new]) {
//            
//            [new setValue:obj forKeyPath:key];
//        }
//        
//    }];
    [self.navigationController pushViewController:new animated:YES];
    
}
//遍历类的所有属性，注意Ivar是遍历所有的包括中括号里面的变量
//    class_copyPropertyList 只遍历@property的属性
-(BOOL)isExistProperty:(NSString *)property inObject:(id)obj{
    unsigned int count;
    //遍历所有属性
    Ivar * ivarList = class_copyIvarList([obj class], &count);
    for (int i = 0;  i < count; i++) {
        Ivar ivar = ivarList[i];
        NSString * name = [NSString stringWithUTF8String:ivar_getName(ivar)];
        //去掉下划线
        name = [name substringFromIndex:1];
        if ([name isEqualToString:property]) {
            return YES;
        }
    }
    //这里是遍历property
    objc_property_t * propertyList = class_copyPropertyList([obj class], &count);
    for (int i = 0;  i < count; i++) {
        objc_property_t property = propertyList[i];
        NSString * name = [NSString stringWithUTF8String:property_getName(property)];
    }
    return NO;
}

@end
