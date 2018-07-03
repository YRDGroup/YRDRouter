//
//  UIColor+YRD.h
//  kjqApp
//
//  Created by yangdeyi1986 on 2018/1/29.
//  Copyright © 2018年 yirendai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (YRD)

+ (UIColor *)YRDColorWithHexString:(NSString *)stringToConvert;
+ (UIColor *)YRDColorWithHexString:(NSString *)stringToConvert alpha:(CGFloat)alpha;

- (UIImage *)imageFromColor;

@end
