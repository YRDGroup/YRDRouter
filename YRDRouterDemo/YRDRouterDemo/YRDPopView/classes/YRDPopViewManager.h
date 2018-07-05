//
//  YRDPopViewManager.h
//  kjqApp
//
//  Created by yangdeyi1986 on 2018/3/7.
//  Copyright © 2018年 yirendai. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YRDPopViewHelper;
@class YRDAbstractPopView;

@interface YRDPopViewManager : NSObject

+ (instancetype)sharedInstance;

- (void)add:(YRDPopViewHelper *)popViewHelper;

- (void)hideAllFor:(Class)popViewClass;

- (void)hideAll;

- (void)enQueue:(YRDPopViewHelper *)popViewHelper;

- (void)deQueue:(YRDPopViewHelper *)popViewHelper;


@end
