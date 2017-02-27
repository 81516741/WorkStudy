//
//  main.m
//  data字节的测试
//
//  Created by yh on 16/3/31.
//  Copyright © 2016年 yh. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        NSMutableData * data = [NSMutableData data];
        NSInteger a = 123;
        NSInteger b = 456;
        [data appendBytes:&b length:sizeof(b)];
        [data appendBytes:&a length:sizeof(a)];
        NSLog(@"\n%@",data);
        NSLog(@"data的长度:%lu",(unsigned long)data.length);
        //前面拼接完后的样子<c8010000 00000000 7b000000 00000000>
        [data resetBytesInRange:NSMakeRange(data.length, 2)];
        //在后面补了2个字节的样子<c8010000 00000000 7b000000 00000000 0000>
        NSLog(@"\n%@",data);
        NSLog(@"data的长度:%lu",(unsigned long)data.length);
        const Byte* bb = [data bytes];
    NSLog(@"0:%02x---1:%02x---2:%02x---3:%02x---4:%02x---5:%02x---6:%02x---7:%02x---8:%02x---9:%02x---10:%02x---11:%02x",bb[0],bb[1],bb[2],bb[3],bb[4],bb[5],bb[6],bb[7],bb[8],bb[9],bb[10],bb[11]);
        
        //byte的数组,byte是一个字节，最大是unsigned char 最大表示255，如果超过了
        //255 例如256 在内存中就是 1 0000 0001所以转成字节就把超过8位的那个1溢出了
        //打印结果  <01ff>   1,255
        Byte byte[] = {257,255};
        NSData * byteData = [NSData dataWithBytes:byte length:sizeof(byte)];
        NSLog(@"%@",byteData);
        NSLog(@"%d,%d",byte[0],byte[1]);
        
    }
    return 0;
}
