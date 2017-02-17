//
//  ViewController.m
//  视频播放器
//
//  Created by yh on 16/5/26.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "ViewController.h"
#import "KRVideoPlayerController.h"
@interface ViewController ()
@property (nonatomic,strong) KRVideoPlayerController * videoController;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    self.videoController = [[KRVideoPlayerController alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width*(9.0/16.0))];
    self.videoController.contentURL = [NSURL URLWithString:@"http://krtv.qiniudn.com/150522nextapp"];
    [self.videoController showInWindow];
}

@end
