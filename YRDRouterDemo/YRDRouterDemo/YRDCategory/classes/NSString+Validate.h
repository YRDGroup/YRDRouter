//
//  NSString+Validate.h
//  kjqApp
//
//  Created by yangdeyi1986 on 2018/2/2.
//  Copyright © 2018年 yirendai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Validate)

- (BOOL)isValidPhoneNumber;

- (BOOL)isValidPassword;

- (BOOL)isValidVerifyCode;

@end
