//
//  main.m
//  block测试
//
//  Created by ld on 16/4/23.
//  Copyright © 2016年 ld. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Dog.h"

typedef void(^blk)();
int main(int argc, const char * argv[]) {
    @autoreleasepool {
       __block int val = 10;
        Dog * dog = [Dog new];
        dog.age = 22;
        
        blk stackBlock = ^{
            dog.age = 10;
            NSLog(@"dog.age = %d",dog.age);
            NSLog(@"val = %d", ++val);
        };
        stackBlock();
        
    }
    return 0;
}
