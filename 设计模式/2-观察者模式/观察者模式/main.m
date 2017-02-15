//
//  main.m
//  观察者模式
//
//  Created by ld on 16/11/28.
//  Copyright © 2016年 ld. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Poster.h"
#import "Observer.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Poster * po = [Poster new];
        Observer * ob = [Observer new];
        [po registerObserver:ob];
        [po update:@"传递对象"];
    }
    return 0;
}
