//
//  ViewController.m
//  测试masonry
//
//  Created by yh on 16/7/14.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"

@interface ViewController ()
@property (nonatomic,strong) UIView * myView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myView = [UIView new];
    [self.view addSubview:_myView];
    _myView.backgroundColor = [UIColor yellowColor];
    
    [_myView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).with.offset(100);
        make.left.mas_equalTo(self.view).with.offset(100);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
}
- (IBAction)btnClick:(UIButton *)sender
{
//    _myView.frame = CGRectMake(20, 20, 200, 200);
    [_myView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view);
    }];
    [UIView animateWithDuration:2 animations:^{
        [self.view layoutIfNeeded];
    }];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view setNeedsLayout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
