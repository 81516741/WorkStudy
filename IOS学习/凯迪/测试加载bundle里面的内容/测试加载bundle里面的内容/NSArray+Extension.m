//
//  NSArray+Description.m
//  9.qq对话框
//
//  Created by mac on 15/9/13.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import "NSArray+Extension.h"

@implementation NSArray (Extension)

-(NSString *)descriptionWithLocale:(id)locale{
    
    NSMutableString * strM = [NSMutableString stringWithFormat:@"("];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [strM appendFormat:@"\n%@",obj];
    }];
    [strM appendFormat:@"\n)"];
    return strM;
}

+(instancetype)arrayWithBundleName:(NSString *)bundleName
{
   return  [NSArray arrayWithContentsOfFile:[[NSBundle bundleWithPath:[[NSBundle mainBundle]pathForResource:@"EmoticonQQ" ofType:@"bundle"]]pathForResource:@"info" ofType:@"plist"]];
}
@end
