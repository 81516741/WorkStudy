//
//  MyView.m
//  LayoutSubView测试
//
//  Created by ld on 17/3/7.
//  Copyright © 2017年 ld. All rights reserved.
//

#import "MyView.h"
#import "Masonry.h"
@implementation MyView

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.childView = [[UIView alloc]init];
    self.childView.backgroundColor = [UIColor yellowColor];
    [self addSubview:self.childView];
    self.childView.frame = CGRectMake(20, 20, 100, 50);
    [self.childView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    [self updateUI];
    self.cons = 50;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self updateUI];
    NSLog(@"diao");
}

- (void)updateUI
{
    
    self.layer.cornerRadius = self.bounds.size.height * 0.5;
    self.layer.masksToBounds = YES;
    
    self.cons += 20;
    NSLog(@"%f",self.cons);
    
//    self.frame = CGRectMake(0, 0, 100, 100);
//    [self mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(self.cons + 100, 100));
//    }];
//    self.cons += 20;
//    [self mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(self.cons + 100, 100));
//    }];
    
//    self.childView.frame = CGRectMake(0, 0, 50 + self.cons, 50);
//    [self.childView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(self.cons + 50, 50));
//    }];
}

@end
