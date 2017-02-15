//
//  NSArray+HYBUnicodeReadable.m
//  demo
//
//  Created by huangyibiao on 15/12/29.
//  Copyright © 2015年 huangyibiao. All rights reserved.
//

#import "NSArray+HYBUnicodeReadable.h"

@implementation NSArray (HYBUnicodeReadable)

- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level {
  NSMutableString *desc = [NSMutableString string];
  
  NSMutableString *tabString = [[NSMutableString alloc] initWithCapacity:level];
  for (NSUInteger i = 0; i < level; ++i) {
    [tabString appendString:@"\t"];
  }
  
  NSString *tab = @"";
  if (level > 0) {
    tab = tabString;
  }
  [desc appendString:@"\t(\n"];
  
  for (id obj in self) {
    if ([obj isKindOfClass:[NSDictionary class]]
        || [obj isKindOfClass:[NSArray class]]
        || [obj isKindOfClass:[NSSet class]]) {
      NSString *str = [((NSDictionary *)obj) descriptionWithLocale:locale indent:level + 1];
      [desc appendFormat:@"%@\t%@,\n", tab, str];
    } else if ([obj isKindOfClass:[NSString class]]) {
      [desc appendFormat:@"%@\t\"%@\",\n", tab, obj];
    } else {
      [desc appendFormat:@"%@\t%@,\n", tab, obj];
    }
  }
  
  [desc appendFormat:@"%@)", tab];
  
  return desc;
}

@end
