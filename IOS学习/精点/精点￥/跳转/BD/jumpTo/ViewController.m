//
//  ViewController.m
//  jumpTo
//
//  Created by kingpoint on 15/12/24.
//  Copyright © 2015年 kingpoint. All rights reserved.
//

#import "ViewController.h"
#import "LoginTableViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)jumpToQQ:(UIButton *)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"qe://"]];
}

//执行Segue的时候将回跳的schemes绑定到目标跳转控制器，这样目标控制器才知道怎么跳回
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    [super prepareForSegue:segue sender:sender];
    LoginTableViewController * loginVc = (LoginTableViewController *)segue.destinationViewController;
    if ([loginVc isKindOfClass:[LoginTableViewController class]]) {
        loginVc.flag = sender;
    }
}


@end
