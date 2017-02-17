//
//  main.m
//  冒泡排序
//
//  Created by yh on 16/8/17.
//  Copyright © 2016年 ld. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSMutableArray * array = @[@2,@4,@6,@1,@7].mutableCopy;
        [array enumerateObjectsUsingBlock:^(NSNumber *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            for (NSUInteger i = idx + 1; i < array.count; i ++) {
                if (obj > array[i]) {
                    [array exchangeObjectAtIndex:idx withObjectAtIndex:i];
                }
            }
        }];
        
//        [array sortUsingComparator:^NSComparisonResult(NSNumber *  _Nonnull obj1, NSNumber *  _Nonnull obj2) {
//            return [obj1 intValue] > [obj2 intValue];
//        }];
        NSLog(@"%@",array);
    }
    return 0;
}
