//
//  ViewController.m
//  LayoutSubView测试
//
//  Created by ld on 17/3/7.
//  Copyright © 2017年 ld. All rights reserved.
//

/*
  总结 :
    1)修改view的layer属性不会触发layoutSubviews
    2)修改view的子视图的frame不会调用layoutSubviews
    3)修改view的frame会调用layoutSubviews
    4)修改view或者view的子视图的cons会触发layoutSubviews
      重点--短时间修改同一属性只会调用一次layoutSubviews
    5)同时修改view的cons 和 frame 只会触发一次layoutSubviews
      最后的尺寸和cons一致
 */

#import "ViewController.h"
#import "MyView.h"
#import "Masonry.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widCons;
@property (weak, nonatomic) IBOutlet MyView *myView;
@property (assign ,nonatomic) CGFloat myViewChildViewCons;
@property (assign ,nonatomic) CGFloat myViewCons;
@property (assign ,nonatomic) BOOL changeFrame;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myViewCons = 20;
    self.myViewChildViewCons = 20;
    self.changeFrame = NO;
}

//改变myView的子view
- (IBAction)btnClick:(id)sender
{
    self.myViewChildViewCons += 1;
    
    if (self.changeFrame) {
        //改变frame
        self.myView.childView.frame = CGRectMake(0, 0, 50 + self.myViewChildViewCons, 50);
        NSLog(@"改变子视图frame");
    } else{
        //改变cons
        [self.myView.childView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(50 + self.myViewChildViewCons, 50));
        }];
        NSLog(@"改变子视图Cons");
    }
    
}

//改变myView
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.myViewCons += 1;
    if (self.changeFrame) {
        //改变frame
        self.myView.frame = CGRectMake(0, 200, 100 + self.myViewCons, 100);
        NSLog(@"改变自身frame");
    } else {
        //改变cons
        [self.myView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(100 + self.myViewCons, 100));
        }];
        
//        //改变frame
//        self.myView.frame = CGRectMake(0, 200, 300 + self.myViewCons, 100);
//        NSLog(@"改变自身frame");
        NSLog(@"改变自身Cons");
    }
}

@end
