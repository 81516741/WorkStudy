//
//  UIView+LD.m
//  圆角半径
//
//  Created by yh on 16/5/4.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "UIView+LD.h"

@implementation UIView (LD)

-(CGFloat)cornerRadius
{
    return self.layer.cornerRadius;
}

-(void)setCornerRadius:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}

@end
