//
//  IBSetView.h
//  圆角半径
//
//  Created by yh on 16/5/4.
//  Copyright © 2016年 ld. All rights reserved.
//  直接让需要设置的view继承这个类就ok了，如果需要设置imageview可以让该类继承imageview

#import <UIKit/UIKit.h>
IB_DESIGNABLE
@interface IBSetView : UIView
//设置圆角
@property(nonatomic,assign) IBInspectable CGFloat cornerRadius;
//设置border
@property(nonatomic,assign) IBInspectable CGFloat borderWidth;
//设置borderCorlor
@property(nonatomic,strong) IBInspectable UIColor * borderCorlor;

@end
