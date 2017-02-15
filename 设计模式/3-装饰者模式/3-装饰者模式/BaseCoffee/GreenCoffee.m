//
//  GreenCoffee.m
//  3-装饰者模式
//
//  Created by ld on 16/11/29.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "GreenCoffee.h"

@implementation GreenCoffee

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
            return 8.0;
            break;
        case SizeOfMiddle:
            return 13.0;
            break;
        case SizeOfBig:
            return 22.0;
            break;
        default:
            return 0.0;
            break;
    }
}
@end
