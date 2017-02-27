//
//  IBSetView.m
//  圆角半径
//
//  Created by yh on 16/5/4.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "IBSetView.h"

@implementation IBSetView

-(void)setCornerRadius:(CGFloat)cornerRadius
{
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}

-(void)setBorderWidth:(CGFloat)borderWidth
{
    _borderWidth = borderWidth;
    self.layer.borderWidth = borderWidth;
}

-(void)setBorderCorlor:(UIColor *)borderCorlor
{
    _borderCorlor = borderCorlor;
    self.layer.borderColor = borderCorlor.CGColor;
}

@end
