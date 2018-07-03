//
//  UIView+YRD.h
//  kjqApp
//
//  Created by yangdeyi1986 on 2018/1/29.
//  Copyright © 2018年 yirendai. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface UIView (YRD)

@property (nonatomic, assign) IBInspectable CGFloat borderWidth;
@property (nonatomic, strong) IBInspectable UIColor *borderColor;
@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;

@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

+ (UINib *)nib;

+ (UIView *)loadFromNib;

- (UIViewController *)viewController;

- (UITapGestureRecognizer *)kjq_addTapGestureTarget:(id)target action:(SEL)action;

@end
