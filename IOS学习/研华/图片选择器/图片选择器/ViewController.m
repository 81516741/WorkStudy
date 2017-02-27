//
//  ViewController.m
//  图片选择器
//
//  Created by yh on 16/5/24.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "ViewController.h"
#import "TZImagePickerController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> * images, NSArray * arrs, BOOL isOK) {
        
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

@end
