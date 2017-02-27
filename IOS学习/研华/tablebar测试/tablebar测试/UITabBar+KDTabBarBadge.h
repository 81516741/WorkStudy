//
//  UITabBar+KDTabBarBadge.h
//  KD_3.0
//
//  Created by kdnet on 16/3/5.
//  Copyright © 2016年 John Tsai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (KDTabBarBadge)

- (void)showBadgeOnItemIndex:(int)index;   //显示小红点

- (void)hideBadgeOnItemIndex:(int)index; //隐藏小红点

@end
