//
//  EmotionCollectionViewCell.h
//  表情包的封装
//
//  Created by yh on 16/3/23.
//  Copyright © 2016年 yh. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LDEmotionPageView;
@interface EmotionCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet LDEmotionPageView *emotionPageView;
@property(nonatomic ,strong) NSArray * emotionArr;

@end
