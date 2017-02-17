//
//  ViewController.m
//  图层裁剪
//
//  Created by ld on 16/12/22.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //用自己绘制的线去剪裁
    UIRectCorner corner = UIRectCornerTopLeft | UIRectCornerTopRight|UIRectCornerBottomLeft;
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(100, 100, 100, 100) byRoundingCorners:corner cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth =20;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.path = path.CGPath;
     
    //用图片去剪裁
    CALayer *maskLayer = [CALayer layer];
    maskLayer.frame = CGRectMake(50, 50, 100, 100);
    UIImage *maskImage = [UIImage imageNamed:@"shake_btn.png"];
    maskLayer.contents = (__bridge id)maskImage.CGImage;
    
    //剪裁￼
    self.imageView.layer.mask = maskLayer;
    
    self.imageView1.layer.mask = shapeLayer;

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
