//
//  UIImage+Extension.m

//
//  Created by mac on 15/9/12.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

+(UIImage *)resizeImage:(NSString *)imageName{
    
    UIImage * image = [UIImage imageNamed:imageName];
    
    image = [image stretchableImageWithLeftCapWidth:image.size.width*0.5 topCapHeight:image.size.height*0.5 ];
    
    return image;
}


#pragma mark - 截屏
+(instancetype)imageCapWithView:(UIImageView *)view{
    
    //开启上下文
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0.0);
    //获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //截图
    [view.layer renderInContext:ctx];
    
    return  UIGraphicsGetImageFromCurrentImageContext();
}

#pragma  mark - 变圆形
+ (instancetype)circleImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
{
    // 1.加载原图
    UIImage *oldImage = [UIImage imageNamed:name];
    
    // 2.开启上下文
    CGFloat imageW = oldImage.size.width + 2 * borderWidth;
    CGFloat imageH = oldImage.size.height + 2 * borderWidth;
    CGSize imageSize = CGSizeMake(imageW, imageH);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    
    // 3.取得当前的上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 4.画边框(大圆)
    [borderColor set];
    CGFloat bigRadius = imageW * 0.5; // 大圆半径
    CGFloat centerX = bigRadius; // 圆心
    CGFloat centerY = bigRadius;
    CGContextAddArc(ctx, centerX, centerY, bigRadius, 0, M_PI * 2, 0);
    CGContextFillPath(ctx); // 画圆
    
    // 5.小圆
    CGFloat smallRadius = bigRadius - borderWidth;
    CGContextAddArc(ctx, centerX, centerY, smallRadius, 0, M_PI * 2, 0);
    // 裁剪(后面画的东西才会受裁剪的影响)
    CGContextClip(ctx);
    
    // 6.画图
    [oldImage drawInRect:CGRectMake(borderWidth, borderWidth, oldImage.size.width, oldImage.size.height)];
    
    // 7.取图
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 8.结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

#pragma  mark - 水印
+(instancetype)imageWaterWithImageName:(NSString *)imageName andText:(NSString *)text{
    
    UIImage * image = [UIImage imageNamed:imageName];
    //开启上下文，这个是在控制器里，而uiview类里面可以直接获取当前上下文
    UIGraphicsBeginImageContextWithOptions(image.size, YES, 0.0);
    
    //因为是要做个水印图片，当然要现在上下文里面画一个图片啊，然后再画文字
    [image drawAtPoint:CGPointZero];
    
    
    //包装一个字典用于设置文字的属性
    NSDictionary * dic = @{
                           NSFontAttributeName:[UIFont systemFontOfSize:18],
                           };
    
    //画文字
    
    CGFloat x = image.size.width * 0.5;
    CGFloat y = image.size.height - 25;
    [text drawAtPoint:CGPointMake(x , y) withAttributes:dic];
    
    return UIGraphicsGetImageFromCurrentImageContext();
    
}

//获取一张指定颜色和大小的图片
+(UIImage *)imageWithBgColor:(UIColor *)color size:(CGSize)size{
    
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

+(instancetype)imageName:(NSString *)imageName inBundleName:(NSString *)bundleName{
    return [UIImage imageNamed:imageName inBundle:[NSBundle bundleWithPath:[[NSBundle mainBundle]pathForResource:bundleName ofType:@"bundle"]] compatibleWithTraitCollection:nil];
}

@end

