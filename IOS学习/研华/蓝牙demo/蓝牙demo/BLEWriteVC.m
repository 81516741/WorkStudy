//
//  BLEWriteVC.m
//  蓝牙demo
//
//  Created by yh on 16/8/18.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "BLEWriteVC.h"
#import "BLEManager.h"
@interface BLEWriteVC()

@property (strong, nonatomic) IBOutlet UILabel *progressLabel;
@property (nonatomic,strong) NSMutableString * progressStr;

@end
@implementation BLEWriteVC

-(void)viewDidLoad
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(startW) name:@"startW" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(WOne) name:@"WOne" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(WOneOK) name:@"WOneOK" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(WOneNOOK) name:@"WOneNOOK" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(WOver) name:@"WOver" object:nil];
    
}

-(void)startW
{
    [self.progressStr appendString:@"开始写数据\n"];
    self.progressLabel.text = self.progressStr;
}
-(void)WOne
{
    [self.progressStr appendString:@"开始每帧数据\n"];
    self.progressLabel.text = self.progressStr;
}
-(void)WOneOK
{
    [self.progressStr appendString:@"每帧数据OK\n"];
    self.progressLabel.text = self.progressStr;
}
-(void)WOneNOOK
{
    [self.progressStr appendString:@"每帧数据不OK\n"];
    self.progressLabel.text = self.progressStr;
}
-(void)WOver
{
    [self.progressStr appendString:@"数据写完\n"];
    self.progressLabel.text = self.progressStr;
}


- (IBAction)write:(UIButton *)sender
{
    self.progressStr = @"".mutableCopy;
    Byte bytes[] = {0x24,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00};
    NSData * data = [NSData dataWithBytes:bytes length:sizeof(bytes)];
    [[BLEManager shareBLE]writeData:data];
}

@end
