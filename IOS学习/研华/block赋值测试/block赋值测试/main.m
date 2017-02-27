//
//  main.m
//  block赋值测试
//
//  Created by yh on 16/4/19.
//  Copyright © 2016年 yh. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
       __block NSString * str = @"fads";
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            str = @"11111";
        });
        NSLog(@"%@",str);
    }
    return 0;
}
