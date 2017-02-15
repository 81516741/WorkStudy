//
//  main.m
//  回文判断
//
//  Created by ld on 17/2/6.
//  Copyright © 2017年 ld. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+Algorithm.h"


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSString * ss = @"a";
        BOOL ok = [ss isPalindrome];
        NSLog(@"%d",ok);
    }
    return 0;
}
