//
//  Milk.m
//  3-装饰者模式
//
//  Created by ld on 16/11/29.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "Milk.h"

@implementation Milk

-(NSString *)getSelfName
{
    return @"牛奶";
}

-(CGFloat)addPrice
{
    switch (self.size) {
        case SizeOfSmall:
            return  18.0;
            break;
        case SizeOfMiddle:
            return  23.0;
            break;
        case SizeOfBig:
            return  28.0;
            break;
        default:
            return  18.0;
            break;
    }
    
}
@end
