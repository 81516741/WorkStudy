//
//  MyPickerView.h
//  时间picker
//
//  Created by yh on 16/7/12.
//  Copyright © 2016年 ld. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyPickerView :  UIPickerView <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong, readonly) NSDate *date;
-(void)selectToday;

@end
