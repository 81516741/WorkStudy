//
//  ViewController.m
//  表情包的封装
//
//  Created by yh on 16/3/23.
//  Copyright © 2016年 yh. All rights reserved.
//

#import "ViewController.h"
#import "EmotionView.h"

@interface ViewController ()<EmotionViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    EmotionView * emotion = [EmotionView emotionView];
    emotion.frame = CGRectMake(20, 50, 320, 219);
    emotion.delegate = self;
    [self.view addSubview:emotion];
}

-(void)emotionViewDidClickEmotion:(LDEmotionModel *)model
{
    NSLog(@"表情传到了外面%@---%s",model,__func__);
}

-(void)emotionViewDidClickDelete
{
    NSLog(@"删除传到了外面---%s",__func__);
}

-(void)emotionViewDidClickSend
{
    NSLog(@"发送传到了外面---%s",__func__);
}


@end
