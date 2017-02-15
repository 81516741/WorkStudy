//
//  PureCoffee.m
//  3-装饰者模式
//
//  Created by ld on 16/11/29.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "PureCoffee.h"

@implementation PureCoffee


-(CGFloat)addPrice
{
    switch (self.size) {
        case SizeOfSmall:
            return 10.0;
            break;
        case SizeOfMiddle:
            return 20.0;
            break;
        case SizeOfBig:
            return 30.0;
            break;
        default:
            return 0.0;
            break;
    }
}

-(NSString *)getSelfName
{
    switch (self.size) {
        case SizeOfSmall:
            return @"纯咖啡小杯";
            break;
        case SizeOfMiddle:
            return @"纯咖啡中杯";
            break;
        case SizeOfBig:
            return @"纯咖啡大杯";
            break;
        default:
            return @"纯咖啡";
            break;
    }
}


@end
