//
//  FlowProgressView.h
//  VinTest
//
//  Created by Vin on 14-12-12.
//  Copyright (c) 2014年 kingpoint. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum _FlowLevel {
    Flow_Level_Ample,//充足，>=10%
    Flow_Level_Tight,//紧张，<10%
    Flow_Level_Drain,//枯竭，==0M
    Flow_Level_Overspend,//超出，<0M
    Flow_Level_NoBusiness//未办理
} FlowLevel;

@protocol FlowProgressViewDelegate;
@interface FlowProgressView : UIView


@property (nonatomic, strong) UIButton *checkComboButton;//查看流量套餐

@property (nonatomic, weak) id<FlowProgressViewDelegate> delegate;

@property (nonatomic, assign) CGFloat progress;

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated;

- (void)setProgress:(CGFloat)progress flowLevel:(FlowLevel)level;

- (void)setShape:(CGPathRef)shape;

- (void)stopAnimation;

@end


@protocol FlowProgressViewDelegate <NSObject>

@optional

- (void)flowProgressViewStartProgress:(FlowProgressView *)flowProgressView;

- (void)flowProgressViewEndedProgress:(FlowProgressView *)flowProgressView;

- (void)flowProgressViewClickCheckCombo:(FlowProgressView *)flowProgressView;

@end
