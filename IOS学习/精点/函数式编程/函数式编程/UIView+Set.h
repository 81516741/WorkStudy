//
//  UIView+Set.h
//  函数式编程
//
//  Created by mac on 16/2/21.
//  Copyright © 2016年 LD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Set)

+(UIView *)set:(UIView *(^)(UIView * view))block;

@end
