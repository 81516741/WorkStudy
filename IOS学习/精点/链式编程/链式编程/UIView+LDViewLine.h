//
//  UIView+LDViewLine.h
//  链式编程
//
//  Created by mac on 16/2/20.
//  Copyright © 2016年 LD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LDViewLine)

-(UIView * (^)(id obj))set;

+(UIView *)setView:(void(^)(UIView * make))block;

@end
