//
//  NSString+Algorithm.h
//  算法_字符串
//
//  Created by ld on 17/2/10.
//  Copyright © 2017年 ld. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(Algorithm)
@property (nonatomic,copy) NSString * (^reverse)(NSInteger from,NSInteger to);
-(NSString *)moveToTail:(NSInteger)count;
-(BOOL)contain:(NSString *)string;
-(BOOL)isPalindrome;
-(NSString *)LongestPalindrome;
@end


@implementation NSString(Algorithm)
@dynamic reverse;
-(NSString *(^)(NSInteger, NSInteger))reverse
{
    return  ^(NSInteger from,NSInteger to){
        NSMutableString * str = self.mutableCopy;
        while (from < to) {
            NSString * fromString = [str substringWithRange:NSMakeRange(from, 1)];
            NSString * toString = [str substringWithRange:NSMakeRange(to, 1)];
            [str replaceCharactersInRange:NSMakeRange(from++, 1) withString:toString];
            [str replaceCharactersInRange:NSMakeRange(to--, 1) withString:fromString];
        }
        return str;
    };
}

-(NSString *)moveToTail:(NSInteger)count
{
    return self.reverse(0,count - 1).reverse(count,self.length - 1).reverse(0,self.length - 1);
}

-(BOOL)contain:(NSString *)string
{
    int hash = 0;
    for (int i = 0; i < self.length; ++i) {
        unichar c = [self characterAtIndex:i];
        hash |= (1 << (c - 'A'));
    }
    for (int i = 0; i < string.length; ++i){
        unichar c = [string characterAtIndex:i];
        if ((hash & (1 << (c - 'A'))) == 0)
        {
            return false;
        }
    }
    return true;
}
-(BOOL)isPalindrome
{
    int length = (int)self.length;
    int temp = (length >> 1) - 1;
    int m = temp >= 0 ? temp : 0;
    const char * str = [self UTF8String];
    const char* first, *second;
    first = str + m;
    second = str + length - 1 - m;
    while (first >= str) {
        if (*first != *second) {
            return false;
        }
        first --;
        second ++;
    }
    return true;
}


-(NSString *)LongestPalindrome
{
    int max = 0,t = 0;
    NSString * maxString;
    for (int i = 0; i < self.length; i++) {
        for (int j = 0; (i - j >=0) && (i + j) < self.length; j ++) {//字符串长度为奇数
            if (!([self characterAtIndex:i - j] == [self characterAtIndex:i + j])) {
                break;
            }
            t = j * 2 + 1;
            if (t > max) {
                max = t;
                maxString = [self substringWithRange:NSMakeRange(i - j, max)];
            }
        }
        
        for (int j = 0; (i - j >=0) && (i + j + 1) < self.length; j ++) {//字符串长度为偶数
            if (!([self characterAtIndex:i - j] == [self characterAtIndex:i + j + 1])) {
                break;
            }
            t = j * 2 + 2;
            if (t > max) {
                max = t;
                maxString = [self substringWithRange:NSMakeRange(i - j, max)];
            }
        }
        
        
    }
    return maxString;
}
@end

