//
//  EmotionCollectionViewCell.m
//  表情包的封装
//
//  Created by yh on 16/3/23.
//  Copyright © 2016年 yh. All rights reserved.
//

#import "EmotionCollectionViewCell.h"
#import "LDEmotionPageView.h"

@implementation EmotionCollectionViewCell

-(void)setEmotionArr:(NSArray *)emotionArr
{
    _emotionArr = emotionArr;
    _emotionPageView.emotions = emotionArr;
    
}

@end
