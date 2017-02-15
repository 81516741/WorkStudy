//
//  main.m
//  设计模式之--1.小鸭子  策略模式
/*
 策略模式就是一个抽象的  超类(父类Duck),定义了Duck的一系列行为，改变行为类对象的方法这些行为的具体实现交给  行为类(是一个实现某些接口的一系列类)，在行为族类里面去具体实现某些方法，这样就可以很好的复用和扩展，具体看下小鸭子例子的设计精髓
 */

#import <Foundation/Foundation.h>
#import "DuckWing.h"
#import "DuckNoWing.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Duck * hasWingDuck = [DuckWing new];
        Duck * noWingDuck = [DuckNoWing new];
        [hasWingDuck perFormMakeSound];
        [noWingDuck perFormMakeSound];
        [noWingDuck changeSoundModel:[SoundBark new]];
        [noWingDuck perFormMakeSound];
    }
    return 0;
}
