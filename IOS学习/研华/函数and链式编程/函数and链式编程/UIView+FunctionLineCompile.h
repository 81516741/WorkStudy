//
//  UIView+FunctionLineCompile.h
//  函数and链式编程
//
//  Created by yh on 16/7/6.
//  Copyright © 2016年 ld. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (FunctionLineCompile)

-(UIView * (^)(id obj))log;

+(UIView *)setView:(UIView * (^)(UIView * view))block;


@end
