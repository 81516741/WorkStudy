//
//  Surger.m
//  3-装饰者模式
//
//  Created by ld on 16/11/29.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "Surger.h"

@implementation Surger

-(NSString *)getSelfName
{
    return @"糖";
}

-(CGFloat)addPrice
{
    switch (self.size) {
        case SizeOfSmall:
            return  28.0;
            break;
        case SizeOfMiddle:
            return  30.0;
            break;
        case SizeOfBig:
            return  32.0;
            break;
        default:
            return  28.0;
            break;
    }
}
@end
