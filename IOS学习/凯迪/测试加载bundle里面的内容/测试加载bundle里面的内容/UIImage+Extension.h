//
//  UIImage+Scale.h
//
//  Created by mac on 15/9/12.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

/**图片拉伸*/
+(UIImage *) resizeImage:(NSString *) imageName;

/**水印*/
+(instancetype) imageWaterWithImageName:(NSString *)imageName andText:(NSString *)text;

/**变成圆形*/
+ (instancetype)circleImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

/**截屏*/
+(instancetype) imageCapWithView:(UIImageView *) view;

/**获取指定颜色和大小的图片*/
+(UIImage *)imageWithBgColor:(UIColor *)color size:(CGSize)size;

+(instancetype)imageName:(NSString *)imageName inBundleName:(NSString *)bundleName;
@end
