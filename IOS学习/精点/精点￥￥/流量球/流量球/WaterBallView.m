//
//  WaterBallView.m
//
//  Created by ld on 16/12/1.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "WaterBallView.h"
#define DefaultWave1Color [UIColor colorWithRed:34/255.0 green:116/255.0 blue:210/255.0 alpha:1]
#define DefaultWave2Color [UIColor colorWithRed:34/255.0 green:116/255.0 blue:210/255.0 alpha:0.3]
@interface WaterBallView()
@property (nonatomic,strong) CAShapeLayer * weave1;
@property (nonatomic,strong) CAShapeLayer * weave2;
@property (nonatomic,strong) CADisplayLink * timer;
@property (assign ,nonatomic) CGFloat startX;

@end
@implementation WaterBallView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.bounds = CGRectMake(frame.origin.x, frame.origin.y, MIN(frame.size.width, frame.size.height), MIN(frame.size.width, frame.size.height));
        self.layer.cornerRadius = MIN(frame.size.width, frame.size.height) * 0.5;
        self.layer.masksToBounds = true;
        self.layer.borderWidth = 2;
        self.layer.borderColor = [UIColor redColor].CGColor;
        
    }
    return self;
}

-(void)setProgress:(CGFloat)progress
{
    _progress = progress;
    self.timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(startAnimation)];
    [self.timer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

-(void)startAnimation
{
    //weave1
    UIBezierPath * path = [UIBezierPath bezierPath];
    self.startX += 1;
    CGPoint point = CGPointMake(0, 10 * sinf(2 * M_PI/self.bounds.size.width * self.startX) + self.bounds.size.height * self.progress);
    [path moveToPoint:point];
    CGFloat y = self.bounds.size.height * self.progress;
    for (CGFloat i = 0.0; i < self.bounds.size.width; i ++) {
        y = 5 * sinf(2 * M_PI/self.bounds.size.width * i + 2 * self.startX * M_PI/self.bounds.size.width) + self.bounds.size.height * self.progress;
        [path addLineToPoint:CGPointMake(i, y)];
    }
    [path addLineToPoint:CGPointMake(self.bounds.size.width, y)];
    [path addLineToPoint:CGPointMake(self.bounds.size.width, self.bounds.size.height)];
    [path addLineToPoint:CGPointMake(0, self.bounds.size.height)];
    [path addLineToPoint:point];
    self.weave1.path = path.CGPath;
    self.weave1.fillColor = DefaultWave1Color.CGColor;
    
    //weave2
    if (!self.signWeave) {
        UIBezierPath * path1 = [UIBezierPath bezierPath];
        [path1 moveToPoint:point];
        CGFloat y1 = self.bounds.size.height * self.progress;
        for (CGFloat i = 0.0; i < self.bounds.size.width; i ++) {
            y1 = 5 * cosf(2 * M_PI/self.bounds.size.width * i + 2 * self.startX * M_PI/self.bounds.size.width ) + self.bounds.size.height * self.progress;
            [path1 addLineToPoint:CGPointMake(i, y1)];
        }
        [path1 addLineToPoint:CGPointMake(self.bounds.size.width, y1)];
        [path1 addLineToPoint:CGPointMake(self.bounds.size.width, self.bounds.size.height)];
        [path1 addLineToPoint:CGPointMake(0, self.bounds.size.height)];
        [path1 addLineToPoint:point];
        self.weave2.path = path1.CGPath;
        self.weave2.fillColor = DefaultWave2Color.CGColor;
    }
   
}

-(CAShapeLayer *)weave1
{
    if (_weave1 == nil) {
        _weave1 = [[CAShapeLayer alloc]init];
        _weave1.frame = self.bounds;
        [self.layer addSublayer:_weave1];
    }
    return _weave1;
}

-(CAShapeLayer *)weave2
{
    if (_weave2 == nil) {
        _weave2 = [[CAShapeLayer alloc]init];
        _weave2.frame = self.bounds;
        [self.layer addSublayer:_weave2];
    }
    return _weave2;
}


@end
