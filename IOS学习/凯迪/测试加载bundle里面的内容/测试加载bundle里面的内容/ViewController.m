//
//  ViewController.m
//  测试加载bundle里面的内容
//
//  Created by yh on 16/3/24.
//  Copyright © 2016年 yh. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+Extension.h"
#import "NSArray+Extension.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //
   id obj =  [[NSBundle bundleWithPath:[[NSBundle mainBundle]pathForResource:@"EmoticonQQ" ofType:@"bundle"]]pathForResource:@"info" ofType:@"plist"];
    id obj1 = [NSArray arrayWithContentsOfFile:obj];

    //加载EmoticonQQ这个bundle里面的info.plist文件
    NSArray * array = [NSArray arrayWithBundleName:@"EmoticonQQ"];
    //加载source这个bundle里面的bookDesk图片
    UIImage * image = [UIImage imageName:@"bookDesk" inBundleName:@"source"];
//    [UIImage imageNamed:@"bookDesk" inBundle:[NSBundle bundleWithPath:[[NSBundle mainBundle]pathForResource:@"source" ofType:@"bundle"]] compatibleWithTraitCollection:nil];
    self.iconImageView.image = image;
    NSLog(@"加载bundle里面的plist文件->%@\n,加载bundle里面的图片->%@\n",image,image);
}



@end
