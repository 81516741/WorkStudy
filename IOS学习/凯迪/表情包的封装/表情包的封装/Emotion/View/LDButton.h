//
//  LDButton.h
//  表情包的封装
//
//  Created by yh on 16/3/24.
//  Copyright © 2016年 yh. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LDEmotionModel;
@interface LDButton : UIButton

@property(nonatomic ,strong) LDEmotionModel * emotionModel;

@end
