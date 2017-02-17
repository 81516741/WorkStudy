//
//  LDEmotionPageView.m
//  1.新浪微博
//
//  Created by mac on 15/10/24.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import "LDEmotionPageView.h"
#import "UIView+Extension.h"
#import "NSString+Emoji.h"
#import "LDButton.h"
#import "LDEmotionModel.h"

#define LDViewTouchDeliver(target,sel) ((void (*)(id,SEL,UIView *))objc_msgSend)((id)target,sel,self)

@interface LDEmotionPageView ()

@end

@implementation LDEmotionPageView

-(void)awakeFromNib
{
    UIButton * deleteBtn = [[UIButton alloc]init];
    [deleteBtn setImage:[UIImage imageNamed:@"delete.png"] forState:UIControlStateNormal];
    [deleteBtn setImage:[UIImage imageNamed:@"delete_high.png"] forState:UIControlStateHighlighted];
    [deleteBtn addTarget:self action:@selector(deleteEmotion) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:deleteBtn];
}

-(void)setEmotions:(NSArray *)emotions{
    
    _emotions = emotions;
    for (UIView * view in self.subviews) {
        if ([view isKindOfClass:[LDButton class]]) {
            [view removeFromSuperview];
        }
    }
    for (int i = 0; i < emotions.count; i ++) {
        LDEmotionModel * model = emotions[i];
        if (model.code.length != 0) {//emoji
            LDButton * btn = [[LDButton alloc]init];
            btn.emotionModel = model;
            [btn setTitle:[NSString emojiWithStringCode:model.code] forState:UIControlStateNormal];
            [btn setImage:nil forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:26];
            [btn setContentMode:UIViewContentModeCenter];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            
        }else if(model.png.length != 0){//浪小花
            
        }else{//qq表情
            LDButton * btn = [[LDButton alloc]init];
            btn.emotionModel = model;
            [btn setImage:[UIImage imageNamed:model.gif inBundle:[NSBundle bundleWithPath:[[NSBundle mainBundle]pathForResource:@"EmoticonQQ" ofType:@"bundle"]] compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
        }
        
        
        
    }
}

-(void)btnclick:(LDButton *)btn
{
    if (btn.emotionModel.code.length != 0) {
        NSLog(@"亲你点击了%@",[NSString emojiWithStringCode:btn.emotionModel.code]);
    }else{
      NSLog(@"亲你点击了%@",btn.emotionModel.chs);
    }
    if (self.seletedEmotion) {
        self.seletedEmotion(btn.emotionModel);
    }
}

-(void)deleteEmotion
{
    NSLog(@"删除");
    if (self.deleteClick) {
        self.deleteClick(nil);
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    NSInteger col;
    NSInteger row;
    NSInteger maxCol = 7;
    NSInteger maxRow = 3;
    CGFloat padding = 10;
    CGFloat btnW = (self.width - 2*padding)/maxCol;
    CGFloat btnH = (self.height - 2*padding)/maxRow;
    UIButton * btn;
    for (int i = 0 ; i < self.emotions.count + 1; i ++) {
        btn = self.subviews[i];
        col = i % maxCol;
        row = i / maxCol;
        if (i >= 1) {
            col = (i - 1) % maxCol;
            row = (i - 1) / maxCol;
        }
        btn.frame = CGRectMake(btnW * col + padding, btnH * row + padding, btnW, btnH);
        if (![btn isKindOfClass:[LDButton class]]) {
            btn.frame = CGRectMake(btnW * 6 + padding + 5, btnH * 2 + padding + 10 , btnW - 14, btnH - 18);
        }
    }
}


@end
