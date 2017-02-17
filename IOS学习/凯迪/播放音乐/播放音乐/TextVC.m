//
//  TextVC.m
//  DriveCloudPhone
//
//  Created by yh on 16/3/30.
//  Copyright © 2016年 yh. All rights reserved.
//

#import "TextVC.h"
#import "SingleObj.h"

@interface TextVC ()

@end

@implementation TextVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [[SingleObj shared] play];
}


@end
