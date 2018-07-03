//
//  NSString+Validate.m
//  kjqApp
//
//  Created by yangdeyi1986 on 2018/2/2.
//  Copyright © 2018年 yirendai. All rights reserved.
//

#import "NSString+Validate.h"

@implementation NSString (Validate)

- (BOOL)isValidPhoneNumber {
  NSString *MOBILEREGEX = @"^(13[0-9]|14[579]|15[0-3,5-9]|16[6]|17[0135678]|18[0-9]|19[89])\\d{8}$";
  NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILEREGEX];
  return [regextestmobile evaluateWithObject:self];
}

- (BOOL)isValidPassword {
  NSString *PASSWORDREGEX = @"^[a-zA-Z0-9_]{8,16}$";
  NSPredicate *regexPassword = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PASSWORDREGEX];
  return [regexPassword evaluateWithObject:self];
}

- (BOOL)isValidVerifyCode {
  NSString *VERIFYCODEREGEX = @"^[0-9]{4,6}";
  NSPredicate *regexVerifyCode = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", VERIFYCODEREGEX];
  return [regexVerifyCode evaluateWithObject:self];
}

@end
