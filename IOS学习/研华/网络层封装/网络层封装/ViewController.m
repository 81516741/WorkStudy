//
//  ViewController.m
//  网络层封装
//
//  Created by yh on 16/4/11.
//  Copyright © 2016年 yh. All rights reserved.
//

#import "ViewController.h"
#import "LDHTTPModel.h"
#import "AFHTTPSessionManager.h"

static NSString * const LDViewControllerTaskDesctription = @"LDViewControllerTaskDesctription";

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    LDHTTPModel * model = [LDHTTPModel new];
    model.httpType = LDHTTPTypePost;
    model.parameters = nil;
    model.taskDescription = LDViewControllerTaskDesctription;
   AFHTTPSessionManager * manager = [LDHTTPManager sendMessage:model success:^(LDHTTPModel *model) {
        
    } failure:^(LDHTTPModel *model) {
        
    }];
    
    AFHTTPSessionManager * manager1 = [LDHTTPManager sendMessage:model success:^(LDHTTPModel *model) {
        
    } failure:^(LDHTTPModel *model) {
        
    }];
    
    
    AFHTTPSessionManager * manager2 = [LDHTTPManager sendMessage:model success:^(LDHTTPModel *model) {
        
    } failure:^(LDHTTPModel *model) {
        
    }];
}



@end
