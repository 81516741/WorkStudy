//
//  ViewController.h
//  播放音乐
//
//  Created by yh on 16/4/28.
//  Copyright © 2016年 ld. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ViewControllerDelegates <NSObject>

-(void)viewDidTouch;

@end

@interface ViewController : UIViewController

@property(nonatomic,weak) id<ViewControllerDelegates> delegate;

@end
