//
//  YRDPopViewHelper.h
//  kjqApp
//
//  Created by yangdeyi1986 on 2018/3/6.
//  Copyright © 2018年 yirendai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YRDPopViewHelper;
@class YRDAbstractPopView;

typedef NS_ENUM(NSInteger, YRDPopViewPopDirection) {
  YRDPopViewPopDirectionNone,
  YRDPopViewPopDirectionAbove,
  YRDPopViewPopDirectionBelow,
  YRDPopViewPopDirectionBelowToCenter,
  YRDPopViewPopDirectionCenter,
  YRDPopViewPopDirectionFillFullScreen,
  YRDPopViewPopDirectionFade,
  YRDPopViewPopDirectionBelowWithPadding
};

typedef NS_ENUM(NSInteger, YRDPopViewPopAnimationStyle) {
  YRDPopViewPopAnimationStyleNormal,
  YRDPopViewPopAnimationStyleSpring
};

typedef NS_ENUM(NSInteger, YRDPopViewMaskStatus) {
  YRDPopViewMaskStatusHidden,
  YRDPopViewMaskStatusTransparent,
  YRDPopViewMaskStatusTransparentAndDisable,
  YRDPopViewMaskStatusNormal,
  YRDPopViewMaskStatusClickDsiable
};

typedef NS_ENUM(NSInteger, YRDPopViewFinalStatus) {
  YRDPopViewFinalStatusUnset,
  YRDPopViewFinalStatusShow,
  YRDPopViewFinalStatusHide
};

typedef NS_ENUM(NSInteger, YRDPopViewPriority) {
  YRDPopViewPriorityHigh = 0,
  YRDPopViewPriorityNormal = 1,
  YRDPopViewPriorityLow = 2
};

@protocol YRDPopViewHelperDelegate <NSObject>

@optional

- (void)popViewHelper:(YRDPopViewHelper *)popViewHelper willShowPopView:(YRDAbstractPopView *)popView;
- (void)popViewHelper:(YRDPopViewHelper *)popViewHelper willHidePopView:(YRDAbstractPopView *)popView;
- (void)popViewHelper:(YRDPopViewHelper *)popViewHelper didShowPopView:(YRDAbstractPopView *)popView;
- (void)popViewHelper:(YRDPopViewHelper *)popViewHelper didHidePopView:(YRDAbstractPopView *)popView;
- (void)popViewHelper:(YRDPopViewHelper *)popViewHelper didClickMask:(UIControl *)mask;

@end

@interface YRDPopViewHelper : NSObject

@property (nonatomic, weak) id<YRDPopViewHelperDelegate> delegate;
@property (nonatomic, weak) YRDAbstractPopView *popView;
@property (nonatomic, strong) YRDAbstractPopView *strongPopView;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, assign) YRDPopViewPopDirection direction;
@property (nonatomic, assign) NSTimeInterval showAnimationDuration;
@property (nonatomic, assign) NSTimeInterval hideAnimationDuration;
@property (nonatomic, assign) NSTimeInterval showAnimationMinDuration;
@property (nonatomic, assign) NSTimeInterval hideAnimationMinDuration;
@property (nonatomic, assign) NSTimeInterval showAnimationSpeed;
@property (nonatomic, assign) NSTimeInterval hideAnimationSpeed;
@property (nonatomic, assign) CGPoint beginningOrigin;
@property (nonatomic, assign) CGPoint showOrigin;
@property (nonatomic, assign) CGPoint endOrigin;
@property (nonatomic, assign) YRDPopViewMaskStatus maskStatus;
@property (nonatomic, assign) CGFloat maskAlpha;
@property (nonatomic, assign) BOOL canForceHide;
@property (nonatomic, assign) YRDPopViewPriority priority;
@property (nonatomic, assign) BOOL shouldLockTargetView;
@property (nonatomic, assign) BOOL shouldAnimatedForShadow;
//@property (nonatomic, assign) BOOL shouldAdjustWithKeyboard;
@property (nonatomic, assign) YRDPopViewPopAnimationStyle animationStyle;
@property (nonatomic, copy) NSArray *popViewAlphaStates;

@property (nonatomic, assign, readonly) BOOL isAnimating;
@property (nonatomic, assign, readonly) YRDPopViewFinalStatus finalStatus;
@property (nonatomic, strong, readonly) UIControl *mask;
@property (nonatomic, assign, readonly) BOOL isShow;

- (instancetype)initWithContainerView:(UIView *)containerView popView:(YRDAbstractPopView *)popView direction:(YRDPopViewPopDirection)direction maskStatus:(YRDPopViewMaskStatus)maskStatus;

- (void)cancelDelayHideIfNeeded;

- (void)showPopViewInQueueWithPriority:(YRDPopViewPriority)priority;

- (void)showPopView:(BOOL)animated;

- (void)hidePopView:(BOOL)animated;

- (void)hidePopViewAfterDelayTime:(NSTimeInterval)delayTime;

- (void)hidePopViewDelayIfNeeded;

@end
