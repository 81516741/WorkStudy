//
//  Chart.m
//  画线
//
//  Created by mac on 15/12/26.
//  Copyright © 2015年 LD. All rights reserved.
//

#import "Chart.h"

@interface Chart()

@property(nonatomic, strong) CAShapeLayer  * graphic;

@end

@implementation Chart

-(CAShapeLayer *)graphic{
    if (_graphic == nil) {
        
        _graphic = [CAShapeLayer layer];
        _graphic.strokeColor = [UIColor redColor].CGColor;
        _graphic.fillColor = [UIColor blueColor].CGColor;
        _graphic.lineWidth = 2;
        [self.layer addSublayer:_graphic];
    }
    
    return _graphic;
}

-(void)awakeFromNib{
    [self drawGraphic];
    NSLog(@"print nib");
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self drawGraphic];
    }
    NSLog(@"print frame");
    return self;
}

-(void)drawGraphic{
    
    //路径
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(20, 20)];
    [path addLineToPoint:CGPointMake(20, 100)];
    [path addLineToPoint:CGPointMake(60, 60)];
    [path addLineToPoint:CGPointMake(100, 100)];
    [path addLineToPoint:CGPointMake(100, 20)];
    [path addLineToPoint:CGPointMake(20, 20)];
    //动画
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = 2;
    animation.fromValue = @0;
    animation.toValue = @1;
    animation.repeatCount = INT32_MAX;
    self.graphic.path = path.CGPath;
    [self.graphic addAnimation:animation forKey:@"strokeEndAnimation"];
   
    
    
}

-(void)drawRect:(CGRect)rect{

   /*
    UIBezierPath 这样就可以画出图线了，简单粗暴，但是，这种方式只可以在
    -(void)drawRect:(CGRect)rect 方法中使用，如果需要在别的地方必须
    用CAShapeLayer 然后添加到self的layer中
    */
    UIBezierPath * path1 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(150, 150) radius:30 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    [path1 stroke];
    
    
    //绘制圆的路径
    UIBezierPath * path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(50, 50) radius:30 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    //创建图层
    CAShapeLayer * layer = [CAShapeLayer layer];
    layer.frame = CGRectMake(200, 300, 100, 100);
    layer.path = path.CGPath;
    layer.lineWidth = 2;
    layer.fillColor = [UIColor greenColor].CGColor;
    layer.strokeColor = [UIColor redColor].CGColor;
    [self.layer addSublayer:layer];
    //创建旋转的动画，怎么设置围绕自己的中心旋转
    CABasicAnimation * animation1 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation1.duration = 0.2;
    animation1.toValue = @1;
    animation1.repeatCount = INT32_MAX;
    animation1.cumulative = TRUE;
    //创建绘制线条的的动画，怎么设置strokeEnd等参数看后面的总结
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @0;
    animation.toValue = @0.9;
    animation.duration = 1;
    layer.strokeEnd = 0.9;
    //添加动画,这里写@"strokeAnimation" 和@"strokeEndAnimation" 测过没影响
    //看以后遇到问题再完善
    [layer addAnimation:animation forKey:@"strokeAnimation"];
    [layer addAnimation:animation1 forKey:@"rotationAnimation"];

  
//以下是关于 怎么围绕自己的中心旋转 等的使用总结**************
    /*
     
    [UIBezierPath bezierPathWithArcCenter:CGPointMake(50, 50) radius:30 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
     上面面是绘制的圆的路径，要想围绕圆的圆心转，只需要将圆心放在图层的中心位置就可以了
     也就是说设置图层时，使图层的中心位置与圆的圆心重合，具体设置如下：
     
     CAShapeLayer * layer = [CAShapeLayer layer];
     layer.frame = CGRectMake(200, 300, 100, 100);
     上面，x = 200，y = 300，是定图层在父图层中的x，y坐标，100 x 100 是图层的大小
     那么图层的中心就是(50,50)，而圆的圆心也是(50,50)，
     也就是说，旋转轴为z轴时，图层会围绕自己的中心转，这里图层的中心是(50,50)
     */
//以上是关于 怎么围绕自己的中心旋转 等的使用总结**************
    
   
    
    
//以下是关于@"strokeStart" @"strokeEnd"等的使用总结**************
    /*
     下面代码1和代码2理解如下：
     注意->这两段代码[CABasicAnimation animationWithKeyPath:@"strokeStart"]
     和 layer.strokeStart 的stroke...后面的参数一样，同时start 和 end
     
     可以这么理解strokeEnd和strokeStart
     strokeEnd 设置fromValue 和 toValue 是和我们的思维一样的 toValue 为结束值
     strokeStart 和我们的思维是反得 fromVale 为结束值
     还要注意后面的layer.strokeStart 或者 layer.strokeEnd 分别在哪里用
     最终决定线条是否显示时看layer.strokeEnd
     */
    //代码1 从有到消失
//    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
//    animation.fromValue = @0;
//    animation.toValue = @1;
//    layer.strokeStart =1;
    
    //代码2 从有到消失        --->>>这个是自己总结出的推荐使用的方式+++++++++++
//    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//    animation.fromValue = @1;
//    animation.toValue = @0;
//    layer.strokeEnd = 0;
    
    /*
     下面代码3和代码4理解如下：
     注意->这两段代码[CABasicAnimation animationWithKeyPath:@"strokeStart"]
     和 layer.strokeStart 的stroke...后面的参数不一致，一个 start 另一个 end
     
     要想最终有线条就要反向思考，animation是end那么layer.strokeStart就要0 因为layer.strokeStart = 0那么end 就是等于1的啊，此时再设置下面两个参数就可以显示，此时是正向思维
     animation.fromValue = @0;
     animation.toValue = @1;
     
     如果layer.strokeStart =1，那么无论怎么设置下面两个的值，毛都不会出现的
     animation.fromValue = @0;
     animation.toValue = @1;
     
     另外的一种同理可推，以后怎么用呢？记住一般用下面这一套，正向思维容易思考
     [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
     animation.fromValue = @0;
     animation.toValue = @1;
     layer.strokeEnd = 1;
     */
////    代码3
//    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//    animation.fromValue = @1;
//    animation.toValue = @1;
//    layer.strokeStart = 1;
//    代码4
//    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
//    animation.fromValue = @0;
//    animation.toValue = @1;
//    layer.strokeEnd = 1;
//以上是关于@"strokeStart" @"strokeEnd"等的使用总结**************


    
    
}
@end
