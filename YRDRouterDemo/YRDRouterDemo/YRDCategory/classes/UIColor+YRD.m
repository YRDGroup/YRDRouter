//
//  UIColor+YRD.m
//  kjqApp
//
//  Created by yangdeyi1986 on 2018/1/29.
//  Copyright © 2018年 yirendai. All rights reserved.
//

#import "UIColor+YRD.h"

@implementation UIColor (YRD)

+ (UIColor *)YRDColorWithHexString:(NSString *)stringToConvert {
  NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
  UIColor *DEFAULT_VOID_COLOR = [UIColor clearColor];
  
  if ([cString length] < 6) {
    return DEFAULT_VOID_COLOR;
  }
  
  if ([cString hasPrefix:@"0X"]) {
    cString = [cString substringFromIndex:2];
  }
  
  if ([cString hasPrefix:@"0x"]) {
    cString = [cString substringFromIndex:2];
  }
  
  if ([cString hasPrefix:@"#"]) {
    cString = [cString substringFromIndex:1];
  }
  
  NSString *alpha = @"FF";
  
  if ([cString length] == 8) {
    alpha  = [cString substringToIndex:2];
    cString = [cString substringFromIndex:2];
  }
  
  if ([cString length] != 6) {
    return DEFAULT_VOID_COLOR;
  }
  
  NSRange range;
  range.location  = 0;
  range.length  = 2;
  NSString *rString = [cString substringWithRange:range];
  
  range.location = 2;
  NSString *gString = [cString substringWithRange:range];
  
  range.location = 4;
  NSString *bString = [cString substringWithRange:range];
  
  unsigned int r, g, b, a;
  [[NSScanner scannerWithString:rString] scanHexInt:&r];
  [[NSScanner scannerWithString:gString] scanHexInt:&g];
  [[NSScanner scannerWithString:bString] scanHexInt:&b];
  [[NSScanner scannerWithString:alpha] scanHexInt:&a];
  
  return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:((float)a / 255.0f)];
}


+ (UIColor *)YRDColorWithHexString:(NSString *)stringToConvert alpha:(CGFloat)alpha {
  NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
  UIColor *DEFAULT_VOID_COLOR = [UIColor clearColor];
  
  if ([cString length] < 6) {
    return DEFAULT_VOID_COLOR;
  }
  
  if ([cString hasPrefix:@"0X"]) {
    cString = [cString substringFromIndex:2];
  }
  
  if ([cString hasPrefix:@"0x"]) {
    cString = [cString substringFromIndex:2];
  }
  
  if ([cString hasPrefix:@"#"]) {
    cString = [cString substringFromIndex:1];
  }
  
  if ([cString length] == 8) {
    cString = [cString substringFromIndex:2];
  }
  
  if ([cString length] != 6) {
    return DEFAULT_VOID_COLOR;
  }
  
  NSRange range;
  range.location  = 0;
  range.length  = 2;
  NSString *rString = [cString substringWithRange:range];
  
  range.location = 2;
  NSString *gString = [cString substringWithRange:range];
  
  range.location = 4;
  NSString *bString = [cString substringWithRange:range];
  
  unsigned int r, g, b;
  [[NSScanner scannerWithString:rString] scanHexInt:&r];
  [[NSScanner scannerWithString:gString] scanHexInt:&g];
  [[NSScanner scannerWithString:bString] scanHexInt:&b];
  
  return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:(alpha)];
}

- (UIImage *)imageFromColor {
  CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
  UIGraphicsBeginImageContext(rect.size);
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSetFillColorWithColor(context, [self CGColor]);
  CGContextFillRect(context, rect);
  UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  return theImage;
}

@end
