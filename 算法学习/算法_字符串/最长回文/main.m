//
//  main.m
//  最长回文
//
//  Created by ld on 17/2/10.
//  Copyright © 2017年 ld. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+Algorithm.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        NSString * maxString = [@"123457887543" LongestPalindrome];
        NSLog(@"%@",maxString);
    }
    return 0;
}

