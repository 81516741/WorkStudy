//
//  LDEmotionPageView.h
//  1.新浪微博
//
//  Created by mac on 15/10/24.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LDEmotionModel;

typedef void(^Block)(LDEmotionModel *);

@interface LDEmotionPageView : UIView

@property(nonatomic, strong) NSArray  * emotions;
/**
 *删除按钮被点击
 */
@property(nonatomic ,copy) Block deleteClick;
/**
 *表情被点击
 */
@property(nonatomic ,copy) Block seletedEmotion;

@end
