//
//  ViewController.m
//  云存储
//
//  Created by hyc on 16/8/11.
//  Copyright © 2016年 hyc. All rights reserved.
//

#import "ViewController.h"
#import <AVOSCloud/AVOSCloud.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //https://leancloud.cn/docs/leanstorage_guide-ios.html
    // Do any additional setup after loading the view, .
//    NSNumber     *boolean    = @(YES);
//    NSNumber     *number     = [NSNumber numberWithInt:2015];
//    NSString     *string     = [NSString stringWithFormat:@"%@ 年度音乐排行", number];
//    NSDate       *date       = [NSDate date];
//    
//    NSData       *data       = [@"短篇小说" dataUsingEncoding:NSUTF8StringEncoding];
//    NSArray      *array      = [NSArray arrayWithObjects:
//                                string,
//                                number,
//                                nil];
//    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
//                                number, @"数字",
//                                string, @"字符串",
//                                nil];
//    
//    AVObject     *object     = [AVObject objectWithClassName:@"DataTypes"];
//    [object setObject:boolean    forKey:@"testBoolean"];
//    [object setObject:number     forKey:@"testInteger"];
//    [object setObject:string     forKey:@"testString"];
//    [object setObject:date       forKey:@"testDate"];
//    [object setObject:data       forKey:@"testData"];
//    [object setObject:array      forKey:@"testArray"];
//    [object setObject:dictionary forKey:@"testDictionary"];
//    [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//        if (succeeded) {
//            NSLog(@"ok");
//        }
//    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    AVObject *anotherTodo = [AVObject objectWithClassName:@"DataTypes" objectId:@"57ac1ab48ac247005fece87d"];
//    anotherTodo.fetchWhenSave = true;// 设置 fetchWhenSave 为 true
//    [anotherTodo saveInBackground];
//    // 然后调用刷新的方法，将数据从云端拉到本地
//    [anotherTodo fetchIfNeededInBackgroundWithBlock:^(AVObject *object, NSError *error) {
//        // 此处调用 fetchIfNeededInBackgroundWithBlock 和 refreshInBackgroundWithBlock 效果一样。
//        NSLog(@"%@",object);
//        
//        
//    }];
    
    
    [AVQuery doCloudQueryInBackgroundWithCQL:@"delete from DataTypes where objectId='57ac1a175bbb500062b2e0c6'" callback:^(AVCloudQueryResult *result, NSError *error) {
        // 如果 error 为空，说明保存成功
        NSLog(@"%@",result);
        if (error) {
            NSLog(@"%@",error);
        }
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
