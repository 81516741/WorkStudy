//
//  Mocha.m
//  3-装饰者模式
//
//  Created by ld on 16/11/29.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "Mocha.h"

@implementation Mocha

-(NSString *)getSelfName
{
    return @"摩卡";
}
-(CGFloat)addPrice
{
    switch (self.size) {
        case SizeOfSmall:
            return  38.0;
            break;
        case SizeOfMiddle:
            return  45.0;
            break;
        case SizeOfBig:
            return  52.0;
            break;
        default:
            return  38.0;
            break;
    }
}
@end
