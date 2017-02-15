//
//  main.m
//  字符包含
//
//  Created by ld on 17/2/6.
//  Copyright © 2017年 ld. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+Algorithm.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSString * a = @"ABC";
        NSString * b = @"AC";
        BOOL ok = [a contain:b];
    }
    return 0;
}
