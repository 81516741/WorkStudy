//
//  UITabBar+KDTabBarBadge.m
//  KD_3.0
//
//  Created by kdnet on 16/3/5.
//  Copyright © 2016年 John Tsai. All rights reserved.
//

#import "UITabBar+KDTabBarBadge.h"

#define TabbarItemNums 4    //tabbar的数量

@implementation UITabBar (KDTabBarBadge)

//显示小红点
- (void)showBadgeOnItemIndex:(int)index{
    //移除之前的小红点
    [self removeBadgeOnItemIndex:index];
    
    //新建小红点
    UIView *badgeView = [[UIView alloc]init];
    badgeView.tag = 888 + index;
    badgeView.layer.cornerRadius = 4;//圆形
    badgeView.backgroundColor = [UIColor redColor];//颜色
//    CGRect tabFrame = self.frame;
    
    //确定小红点的位置 大小
    float perWidth = [UIScreen mainScreen].bounds.size.width / TabbarItemNums;
    
    badgeView.frame = CGRectMake(perWidth *index + (perWidth + 25 )*0.5 + 2, 5.0, 8.0, 8.0);
    [self addSubview:badgeView];
}

//隐藏小红点
- (void)hideBadgeOnItemIndex:(int)index{
    //移除小红点
    [self removeBadgeOnItemIndex:index];
}

//移除小红点
- (void)removeBadgeOnItemIndex:(int)index{
    //按照tag值进行移除
    for (UIView *subView in self.subviews) {
        if (subView.tag == 888+index) {
            [subView removeFromSuperview];
        }
    }
}
@end
