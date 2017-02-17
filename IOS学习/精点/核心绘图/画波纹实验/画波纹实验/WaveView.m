//
//  WaveView.m
//  画波纹实验
//
//  Created by mac on 15/12/27.
//  Copyright © 2015年 LD. All rights reserved.
//

#import "WaveView.h"

@implementation WaveView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor greenColor];
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
    
    
    UIBezierPath * path = [UIBezierPath bezierPath];
    
    float waveHeight = rect.size.height*(1-0.3);
    float y = waveHeight;
    [path moveToPoint:CGPointMake(10, y)];
    for (float x=10; x<=rect.size.width-10; x++){
        
        y =  sin(3*x/rect.size.width*M_PI) * 10 + waveHeight;
        [path addLineToPoint:CGPointMake(x, y)];

    }
    [path addLineToPoint:CGPointMake(rect.size.width-10, rect.size.height-10)];
    [path addLineToPoint: CGPointMake(10, rect.size.height-10)];
    [path addLineToPoint:CGPointMake(10, sin(3*10/rect.size.width*M_PI) * 10 + waveHeight)];
    [[UIColor blueColor]set];
    [path fill];
    
    //创建图层
    CAShapeLayer * layer = [CAShapeLayer layer];
    layer.frame = rect;
    layer.path = path.CGPath;
    layer.lineWidth = 2;
    layer.fillColor = [UIColor greenColor].CGColor;
    layer.strokeColor = [UIColor redColor].CGColor;
    [self.layer addSublayer:layer];
    //创建旋转的动画，怎么设置围绕自己的中心旋转
    CABasicAnimation * animation1 = [CABasicAnimation animationWithKeyPath:@"fillEnd"];
    animation1.duration = 2;
    animation1.fromValue = @0;
    animation1.toValue = @1;
//    animation1.repeatCount = INT32_MAX;
//    animation1.cumulative = TRUE;
    [layer addAnimation:animation1 forKey:@"fillAnimation"];
    
}

@end
