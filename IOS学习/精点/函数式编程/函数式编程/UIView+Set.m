//
//  UIView+Set.m
//  函数式编程
//
//  Created by mac on 16/2/21.
//  Copyright © 2016年 LD. All rights reserved.
//

#import "UIView+Set.h"
static UIView * _view;
@implementation UIView (Set)

+(UIView *)set:(UIView *(^)(UIView *))block
{
    _view = [[UIView alloc]init];
    _view = block(_view);
    return _view;
}

@end
