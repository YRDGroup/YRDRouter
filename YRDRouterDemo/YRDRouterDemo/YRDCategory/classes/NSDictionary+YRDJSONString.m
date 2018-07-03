//
//  NSDictionary+YRDJsonString.m
//  kjqApp
//
//  Created by yangdeyi1986 on 2018/3/20.
//  Copyright © 2018年 yirendai. All rights reserved.
//

#import "NSDictionary+YRDJSONString.h"

@implementation NSDictionary (YRDJSONString)

- (NSString *)jsonString {
  NSString *jsonString = nil;
  NSError *error;
  NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
  if (! jsonData) {
    NSLog(@"Got an error: %@", error);
  } else {
    jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
  }
  
  return jsonString;
}

@end
