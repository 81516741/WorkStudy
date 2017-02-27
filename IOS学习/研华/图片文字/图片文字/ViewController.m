//
//  ViewController.m
//  图片文字
//
//  Created by yh on 16/5/12.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage * image = [self createShareImage:@"hahah" imageColor:[UIColor redColor] imageSize:CGSizeMake(100, 100) font:18.0 worldX:10];
    UIImageView * imageView = [[UIImageView alloc]initWithImage:image];
    imageView.frame = CGRectMake(100, 100, 100, 100);
    
    [self.view addSubview:imageView];
}

//获取一张指定颜色和大小的图片
-(UIImage *)imageWithBgColor:(UIColor *)color size:(CGSize)size{
    
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
    
}

//获取带文字的图片worldX 文字的起始点
- ( UIImage *)createShareImage:( NSString *)str imageColor:(UIColor * )color imageSize:(CGSize)size font:(CGFloat)font worldX:(CGFloat)worldX;
{
    
    UIImage *image = [self imageWithBgColor:color size:size];

    UIGraphicsBeginImageContextWithOptions (size, NO , 0.0 );
    
    [image drawAtPoint:CGPointMake(0,0)];
    
    // 获得一个位图图形上下文
    
    CGContextRef context= UIGraphicsGetCurrentContext();
    
    CGContextDrawPath (context, kCGPathStroke );
    
    // 画 打败了多少用户
    
    [str drawAtPoint : CGPointMake (worldX,(size.height - font)*0.5) withAttributes : @{ NSFontAttributeName :[ UIFont fontWithName : @"Arial-BoldMT" size : font ], NSForegroundColorAttributeName :[ UIColor whiteColor ] } ];
    
    //画自己想画的内容。。。。。
    
    // 返回绘制的新图形
    
    UIImage *newImage= UIGraphicsGetImageFromCurrentImageContext ();
    
    UIGraphicsEndImageContext ();
    
    return newImage;
    
}

//这个是用来获取一个文字图片的，文字多大，图片就多大
//获取带文字的图片worldX 文字的起始点
-( UIImage *)createImageWithColor:(UIColor * )color worlds:( NSString *)worlds worldsColor:(UIColor * )worldsColor font:(CGFloat)font worldX:(CGFloat)worldX
{
    //    [ UIFont fontWithName : @"Arial-BoldMT" size : font ]
    NSDictionary * attributesDic = @{ NSFontAttributeName :[ UIFont systemFontOfSize:font], NSForegroundColorAttributeName :worldsColor};
    
    CGRect worldsRect = [worlds boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributesDic context:nil];
    
    UIImage *image = [self imageWithBgColor:color size:worldsRect.size];
    
    UIGraphicsBeginImageContextWithOptions (image.size, NO , 0.0 );
    
    [image drawAtPoint:CGPointMake(0,0)];
    
    // 获得一个位图图形上下文
    
    CGContextRef context= UIGraphicsGetCurrentContext();
    
    CGContextDrawPath (context, kCGPathStroke );
    
    // 画 打败了多少用户
    
    [worlds drawAtPoint : CGPointMake (worldX,(image.size.height - font)*0.5) withAttributes :attributesDic];
    
    //画自己想画的内容。。。。。
    
    // 返回绘制的新图形
    
    UIImage *newImage= UIGraphicsGetImageFromCurrentImageContext ();
    
    UIGraphicsEndImageContext ();
    
    return newImage;
    
}


@end
