//
//  UIView+FunctionLineCompile.m
//  函数and链式编程
//
//  Created by yh on 16/7/6.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "UIView+FunctionLineCompile.h"

@implementation UIView (FunctionLineCompile)

-(UIView *(^)(id))log
{
    return ^(id obj){
        NSLog(@"%@",obj);
        return self;
    };
}


+(UIView *)setView:(UIView *(^)(UIView *))block
{
    UIView * view = [UIView new];
    block(view);
    return view;
}

@end

