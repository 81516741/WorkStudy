//
//  UIView+LDViewLine.m
//  链式编程
//
//  Created by mac on 16/2/20.
//  Copyright © 2016年 LD. All rights reserved.
//

#import "UIView+LDViewLine.h"

@implementation UIView (LDViewLine)

-(UIView *(^)(id))set
{
    return ^(id obj){
        if ([obj isKindOfClass:[UIColor class]]) {
            self.backgroundColor = (UIColor *)obj;
        }else{
            NSValue * rectValue = (NSValue *)obj;
            CGRect frame = [rectValue CGRectValue];
            self.frame = frame;
        }
        return self;
    };
}

+(UIView *)setView:(void (^)(UIView *))block
{
    UIView * view = [[UIView alloc]init];
    block(view);
    return view;
}

@end
