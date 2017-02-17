//
//  ViewController.m
//  10086动画图片
//
//  Created by ld on 16/9/6.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *bImageView;
@property (weak, nonatomic) IBOutlet UIImageView *fImageView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *hConstain;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"有用吗");
    self.view.userInteractionEnabled = false;
    _hConstain.constant = 0;
    [UIView animateWithDuration:0.5 animations:^{
        [self.view layoutIfNeeded];
    }completion:^(BOOL finished) {
        _hConstain.constant = 50;
        self.view.userInteractionEnabled = true;
    }];
}

@end
