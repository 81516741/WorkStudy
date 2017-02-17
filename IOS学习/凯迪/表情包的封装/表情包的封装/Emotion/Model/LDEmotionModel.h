//
//  LDEmotionModel.h
//  1.新浪微博
//
//  Created by mac on 15/10/24.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LDEmotionModel : NSObject
/**emoji  的 code*/
@property(nonatomic, copy) NSString  * code;
/**表情的标示字符*/
@property(nonatomic, copy) NSString  * chs;
/**表情图片*/
@property(nonatomic, copy) NSString  * png;
/**表情图片*/
@property(nonatomic, copy) NSString  * gif;

@end
