//
//  main.m
//  4-工厂模式
//
//  Created by ld on 16/11/29.
//  Copyright © 2016年 ld. All rights reserved.
//
/*
    原本我想把之前自己写的一个topbar的框架也用工厂模式
    发现属性也用工厂模式，子类重写get方法不太合适，应为有一些高度是需要结合
    具体内容去获得的，而在get方法中获取就不太方便，还有指示条的高度，也是
    根据具体内容去设置的，所以以后用工厂模式 属性就尽量不要用，直接有子类
    设置就可以了，而滑动到了第几页 ，这个可以由子类去实现，这里只是监听，与
    真是的工厂模式有一定的区别，以后别老想着工厂工厂模式，灵活变通吧
 */

#import <Foundation/Foundation.h>
#import "GuanZhuangPizzStore.h"
#import "YuanLIngPizzStore.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        PizzBase * pizz = [GuanZhuangPizzStore orderPizz];
        NSLog(@"%@--%@",pizz.name,pizz.price);
    }
    return 0;
}
