//
//  YRDRouter+View.m
//  YRDRouterDemo
//
//  Created by 李二狗 on 2018/7/4.
//  Copyright © 2018年 李二狗. All rights reserved.
//

#import "YRDRouter+View.h"
#import <UIKit/UIKit.h>

@implementation YRDRouter (View)

+ (id)view_initViewWithClassName:(NSString *)className type:(NSString *)type
{
    if (type == nil || type.length == 0) {
        return [[NSClassFromString(className) alloc]initWithFrame:CGRectZero];
    }
    if ([type.lowercaseString isEqualToString:@"xib"]) {
        UINib *nib = [UINib nibWithNibName:className bundle:[NSBundle mainBundle]];
        return [nib instantiateWithOwner:nil options:nil].firstObject;
    }
    return nil;
}

@end
