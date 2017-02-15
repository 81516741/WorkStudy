//
//  main.m
//  try-catch练习
//
//  Created by ld on 16/4/23.
//  Copyright © 2016年 ld. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
       
        NSArray * arr = @[@"niaho",@"zaima"];
        @try {
            [arr objectAtIndex:4];
        } @catch (NSException *exception) {
            NSLog(@"----%@",exception);
        }
    }
    return 0;
}
