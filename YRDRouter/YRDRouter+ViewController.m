//
//  YRDRouter+ViewController.m
//  YRDRouterDemo
//
//  Created by 李二狗 on 2018/7/3.
//  Copyright © 2018年 李二狗. All rights reserved.
//

#import "YRDRouter+ViewController.h"
#import <UIKit/UIKit.h>


@implementation YRDRouter (ViewController)

+ (id)vc_initViewControllerWithClassName:(NSString *)className type:(NSString *)type {
   
    if (type == nil || type.length == 0) {
        return [[NSClassFromString(className) alloc]init];
    }
    if ([type.lowercaseString isEqualToString:@"xib"]) {
       return [(UIViewController *)[NSClassFromString(className) alloc] initWithNibName:className bundle: nil];
    } else {
       UIStoryboard *storyboard = [UIStoryboard storyboardWithName:type bundle:nil];
       return [storyboard instantiateViewControllerWithIdentifier:className];
    }
}



@end
