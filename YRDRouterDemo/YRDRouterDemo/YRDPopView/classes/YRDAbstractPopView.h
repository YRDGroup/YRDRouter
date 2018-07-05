//
//  YRDAbstractPopView.h
//  kjqApp
//
//  Created by yangdeyi1986 on 2018/3/6.
//  Copyright © 2018年 yirendai. All rights reserved.
//

#import "YRDPopViewHelper.h"

@interface YRDAbstractPopView : UIView

@property (nonatomic, strong) YRDPopViewHelper *helper;

- (instancetype)initWithSize:(CGSize)size direciton:(YRDPopViewPopDirection)direction maskStatus:(YRDPopViewMaskStatus)maskStatus;

- (void)initPopViewHelperWithSize:(CGSize)size direciton:(YRDPopViewPopDirection)direction maskStatus:(YRDPopViewMaskStatus)maskStatus;

- (void)show;

- (void)hide;

- (void)autoHidePopViewAfter:(NSTimeInterval)delayTime;

- (void)toggle;

@end
