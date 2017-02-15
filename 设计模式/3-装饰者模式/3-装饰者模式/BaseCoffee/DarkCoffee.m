//
//  DarkCoffee.m
//  3-装饰者模式
//
//  Created by ld on 16/11/29.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "DarkCoffee.h"

@implementation DarkCoffee

-(NSString *)getSelfName
{
    switch (self.size) {
        case SizeOfSmall:
            return @"黑咖啡小杯";
            break;
        case SizeOfMiddle:
            return @"黑咖啡中杯";
            break;
        case SizeOfBig:
            return @"黑咖啡大杯";
            break;
        default:
            return @"黑咖啡";
            break;
    }
}
-(CGFloat)cost
{
    switch (self.size) {
        case SizeOfSmall:
            return 5.0;
            break;
        case SizeOfMiddle:
            return 10.0;
            break;
        case SizeOfBig:
            return 15.0;
            break;
        default:
            return 0.0;
            break;
    }
}

@end
