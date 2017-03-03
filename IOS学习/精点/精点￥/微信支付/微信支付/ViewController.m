//
//  ViewController.m
//  微信支付
//
//  Created by 莫至钊 on 15/12/7.
//  Copyright © 2015年 莫至钊. All rights reserved.
//

#import "ViewController.h"
#import "WXApi.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)buttonAction:(UIButton *)sender {
    
    // 实现微信支付
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:@"http://wxpay.weixin.qq.com/pub_v2/app/app_pay.php?plat=ios"] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@", dic);
        
        // 对PayReq 每个属性赋值
        PayReq *req = [[PayReq alloc] init];
        req.partnerId = [dic objectForKey:@"partnerid"];
        req.sign = [dic objectForKey:@"sign"];
        req.nonceStr = [dic objectForKey:@"noncestr"];
        req.package = [dic objectForKey:@"package"];
        req.prepayId = [dic objectForKey:@"prepayid"];
        req.timeStamp = [[dic objectForKey:@"timeStamp"] intValue];
        
        // 发送支付请求
        [WXApi sendReq:req];
    }];
    [dataTask resume];
}











@end
