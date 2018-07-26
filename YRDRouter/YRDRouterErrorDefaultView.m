//
//  YRDRouterErrorDefaultView.m
//  YRDRouterDemo
//
//  Created by 李二狗 on 2018/7/26.
//  Copyright © 2018年 李二狗. All rights reserved.
//

#import "YRDRouterErrorDefaultView.h"
#import <UIKit/UIKit.h>
@implementation YRDRouterErrorDefaultView

- (void)show {
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED <= __IPHONE_9_0
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"页面跳转异常" message:@"请更新版本或稍后再试" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil];
    [alertView show];
#else
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"页面跳转异常" message:@"请更新版本或稍后再试" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVC addAction:cancelAction];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVC animated:YES completion:^{
        
    }];
#endif

}

@end
