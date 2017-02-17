//
//  EmotionView.h
//  表情包的封装
//
//  Created by yh on 16/3/23.
//  Copyright © 2016年 yh. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kEmotionCollectionView @"EmotionCollectionViewCell"
@class LDEmotionModel;
@protocol EmotionViewDelegate <NSObject>
@optional
-(void)emotionViewDidClickEmotion:(LDEmotionModel *)model;
-(void)emotionViewDidClickDelete;
-(void)emotionViewDidClickSend;
@end

@interface EmotionView : UIView

+(instancetype)emotionView;
@property(nonatomic ,assign) id<EmotionViewDelegate> delegate;

@end
