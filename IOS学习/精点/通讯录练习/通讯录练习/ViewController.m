//
//  ViewController.m
//  通讯录练习
//
//  Created by kingpoint on 15/12/28.
//  Copyright © 2015年 kingpoint. All rights reserved.
//

#import "ViewController.h"
#import <ContactsUI/ContactsUI.h>
@interface ViewController ()<CNContactPickerDelegate>

@end

@implementation ViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CNContactPickerViewController * vc = [[CNContactPickerViewController alloc]init];
    vc.delegate = self;
    [self presentViewController:vc animated:YES completion:nil];

}

- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact{
    
    NSLog(@"%@---%@",contact.familyName,contact.givenName);
}

@end
