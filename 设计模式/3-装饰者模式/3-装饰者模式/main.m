//
//  main.m
//  3-装饰者模式
//
//  Created by ld on 16/11/29.
//  Copyright © 2016年 ld. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PureCoffee.h"
#import "DarkCoffee.h"
#import "GreenCoffee.h"
#import "Milk.h"
#import "Surger.h"
#import "Mocha.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        OriginComponent * pure = [PureCoffee instanceWithSize:SizeOfBig];
        //这里的装饰是根据杯子大小不同 一份milk 或者 surger 价格也不一样
        pure = [Milk decorate:pure];
        pure = [Surger decorate:pure];
        pure = [Milk moveDecorate:pure];
        pure = [Milk moveDecorate:pure];
        NSLog(@"%@",[pure getdescriptionString]);
        NSLog(@"%f",[pure cost]);
    }
    return 0;
}
