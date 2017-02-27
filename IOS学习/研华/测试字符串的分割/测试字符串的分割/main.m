//
//  main.m
//  测试字符串的分割
//
//  Created by yh on 16/3/23.
//  Copyright © 2016年 yh. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        NSString * str = @"1,2,,";
        NSArray * arr = [str componentsSeparatedByString:@","];
        NSLog(@"%@",arr);
        /* 打印结果 数组里面有4个元素
         1,
         2,
         "",
         ""
         */
    }
    return 0;
}
