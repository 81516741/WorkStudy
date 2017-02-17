//
//  MyObj.m
//  递归
//
//  Created by ld on 16/10/14.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "MyObj.h"

@implementation MyObj
+(NSInteger)function:(NSInteger)num
{
    if (num == 0) {
        return 0;
    }
    if (num == 1) {
        return 1;
    }
    
    return [MyObj function:num - 1] + [MyObj function:num - 2];
}

+(NSInteger)funtctionAdd:(NSInteger)num
{
    if (num == 1) {
        return 1;
    }
    return [MyObj funtctionAdd:num - 1] + num;
}

+(NSInteger)functionMulti:(NSInteger)num
{
    if (num == 1 || num == 0) {
        return 1;
    }
    return [MyObj functionMulti:num - 1] * num;
}
@end
