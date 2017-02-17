//
//  ViewController.m
//  emoji测试
//
//  Created by yh on 16/5/16.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "ViewController.h"
#import "YYLabel.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *textFeild;
@property (weak, nonatomic) IBOutlet UIButton *showBtn;
@property (weak, nonatomic) IBOutlet YYLabel *yylable;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)showBtnClick:(id)sender {
    self.titleLabel.text = self.textFeild.text;
    NSAttributedString * str = [[NSAttributedString alloc]initWithString:self.textFeild.text];
    self.yylable.attributedText = str;
}



@end
