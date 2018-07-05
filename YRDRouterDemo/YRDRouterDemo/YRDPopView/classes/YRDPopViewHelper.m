//
//  YRDPopViewHelper.m
//  kjqApp
//
//  Created by yangdeyi1986 on 2018/3/6.
//  Copyright © 2018年 yirendai. All rights reserved.
//

#import "YRDPopViewHelper.h"

#import "YRDAbstractPopView.h"
#import "YRDPopViewManager.h"

@interface YRDPopViewHelper()

@property (nonatomic, assign) BOOL isAnimating;
@property (nonatomic, assign) YRDPopViewFinalStatus finalStatus;
@property (nonatomic, strong) UIControl *mask;
@property (nonatomic, assign) BOOL isShow;
@property (nonatomic, assign) CGFloat spring;
@property (nonatomic, assign) CGFloat beginningVelocity;
@property (nonatomic, assign) CGRect currentFrame;
@property (nonatomic, assign) CGFloat popViewShadowOpacity;
@property (nonatomic, assign) NSTimeInterval delayHideTime;
@property (nonatomic, strong) UIView *compensationView; // 适配phoneX

@end

@implementation YRDPopViewHelper

- (instancetype)initWithContainerView:(UIView *)containerView popView:(YRDAbstractPopView *)popView direction:(YRDPopViewPopDirection)direction maskStatus:(YRDPopViewMaskStatus)maskStatus {
  self = [super init];
  if (self) {
    [self config];
    self.containerView = containerView;
    self.popView = popView;
    self.direction = direction;
    self.maskStatus = maskStatus;
    
    self.popView.hidden = YES;
    
    if (containerView == nil) {
      self.containerView = [UIApplication sharedApplication].keyWindow;
      [YRDPopViewManager.sharedInstance add:self];
    }
    
    [self initMaskStatus:maskStatus];
   ;
  }
  
  return self;
}

- (void)dealloc {
  [self.mask removeFromSuperview];
  [self.popView removeFromSuperview];
}

- (void)setDirection:(YRDPopViewPopDirection)direction {
  _direction = direction;
  if (direction == YRDPopViewPopDirectionFade) {
    _showAnimationMinDuration = 1;
    _hideAnimationMinDuration = 1;
  }
}

- (void)config {
  self.popViewAlphaStates = @[@(1), @(1), @(1)];
  self.showAnimationDuration = 0.25;
  self.showAnimationMinDuration = 0.25;
  self.hideAnimationDuration = 0.25;
  self.hideAnimationMinDuration = 0.25;
  self.showAnimationSpeed = 1500;
  self.hideAnimationSpeed = 1500;
  self.beginningOrigin = CGPointZero;
  self.endOrigin = CGPointZero;
  self.showOrigin = CGPointZero;
  self.maskAlpha = 0.3;
  self.canForceHide = YES;
  self.shouldLockTargetView = NO;
  self.shouldAnimatedForShadow = NO;
  self.isShow = NO;
  self.isAnimating = NO;
  self.spring = 1.0;
  self.beginningVelocity = 0;
  self.popViewShadowOpacity = 0;
}

#pragma mark - public

- (void)showPopViewInQueueWithPriority:(YRDPopViewPriority)priority {
  self.priority = priority;
  [YRDPopViewManager.sharedInstance enQueue:self];
}

- (void)cancelDelayHideIfNeeded {
  if (self.delayHideTime <= 0) {
    return;
  }
  
  [NSObject cancelPreviousPerformRequestsWithTarget:self];
  self.delayHideTime = 0;
}

- (void)showPopView:(BOOL)animated {
  self.finalStatus = YRDPopViewFinalStatusShow;
  
  if (self.isAnimating) {
    return;
  }
  
  if (self.isShow) {
    return;
  }
  
  [self configPopViewDirection];
  [self setUpUI];
  
  if (self.mask) {
    [self.containerView bringSubviewToFront:self.mask];
  }
  
  [self.containerView addSubview:self.popView];
  [self.containerView bringSubviewToFront:self.popView];
  self.popView.hidden = NO;
  self.isShow = YES;
  self.isAnimating = YES;
  
  if (self.shouldAnimatedForShadow) {
    self.popView.layer.shadowOpacity = self.popViewShadowOpacity;
  }
  
  if ([self.delegate respondsToSelector:@selector(popViewHelper:willShowPopView:)]) {
     [self.delegate popViewHelper:self willShowPopView:self.popView];
  }
 
  if (animated) {
    NSTimeInterval duration = self.showAnimationDuration > self.showAnimationMinDuration ? self.showAnimationDuration : self.showAnimationMinDuration;
    [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:self.spring initialSpringVelocity:self.beginningVelocity options:UIViewAnimationOptionLayoutSubviews animations:^{
      [self showAction];
    } completion:^(BOOL finished) {
      if (finished) {
        [self showCompletionAction];
      }
    }];
  } else {
    [self showAction];
    [self showCompletionAction];
  }
}

- (void)hidePopView:(BOOL)animated {
  self.finalStatus = YRDPopViewFinalStatusHide;
  
  if (self.isAnimating) {
    return;
  }
  
  if (!self.isShow) {
    return;
  }
  
  self.isAnimating = YES;
  if ([self.delegate respondsToSelector:@selector(popViewHelper:willHidePopView:)]) {
    [self.delegate popViewHelper:self willHidePopView:self.popView];
  }
  
  if (self.shouldAnimatedForShadow) {
    self.popView.layer.shadowOpacity = 0;
  }
  
  if (animated) {
    NSTimeInterval duration = self.hideAnimationDuration > self.hideAnimationMinDuration ? self.hideAnimationDuration : self.hideAnimationMinDuration;
    [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:self.spring initialSpringVelocity:self.beginningVelocity options:UIViewAnimationOptionLayoutSubviews animations:^{
      [self hideAction];
    } completion:^(BOOL finished) {
      if (finished) {
        [self hideCompletionAction];
      }
    }];
  } else {
    [self hideAction];
    [self hideCompletionAction];
  }
}

- (void)hidePopViewAfterDelayTime:(NSTimeInterval)delayTime {
  if (delayTime <= 0) {
    return;
  }
  
  self.delayHideTime = delayTime;
  [self hidePopViewDelayIfNeeded];
}

- (void)hidePopViewDelayIfNeeded {
  if (self.delayHideTime <= 0) {
    return;
  }
  
  if (!self.isShow) {
    return;
  }
  
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.delayHideTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    [self hidePopView:YES];
  });
}


#pragma mark - private

- (void)initMaskStatus:(YRDPopViewMaskStatus)maskStatus {
  if (maskStatus == YRDPopViewMaskStatusHidden) {
    return;
  }
  
  self.mask = [[UIControl alloc] initWithFrame:self.containerView.frame];
  self.mask.alpha = 0;
  BOOL isTransparent = maskStatus == YRDPopViewMaskStatusTransparent || maskStatus == YRDPopViewMaskStatusTransparentAndDisable;
  
  [self.containerView addSubview:self.mask];
  self.mask.backgroundColor = isTransparent ? [UIColor clearColor] : [UIColor blackColor];
  [self.mask addTarget:self action:@selector(onClickMask) forControlEvents:UIControlEventTouchUpInside];
}

- (void)onClickMask {
  if (self.mask && [self.delegate respondsToSelector:@selector(popViewHelper:didClickMask:)]) {
    [self.delegate popViewHelper:self didClickMask:self.mask];
  }
  
  BOOL clickEnable = self.maskStatus != YRDPopViewMaskStatusClickDsiable && self.maskStatus != YRDPopViewMaskStatusTransparentAndDisable;
  if (clickEnable) {
    [self hidePopView:YES];
  }
}

- (void)configPopViewDirection {
  CGFloat inset = 0;
  
  switch (self.direction) {
    case YRDPopViewPopDirectionAbove:
      self.beginningOrigin = CGPointMake(0, -self.popView.frame.size.height);
      
      if (@available(iOS 11.0, *)) {
        self.showOrigin = CGPointMake(0, self.containerView.safeAreaInsets.top);
        [self.compensationView setFrame:CGRectMake(0, -inset, self.containerView.frame.size.width, inset)];
        self.compensationView.backgroundColor = self.popView.backgroundColor;
      } else {
        self.showOrigin = CGPointMake(0, 0);
      }
      
      self.endOrigin = self.beginningOrigin;
      break;
      
    case YRDPopViewPopDirectionBelow:
      self.beginningOrigin = CGPointMake(0, CGRectGetMaxY(self.containerView.frame));
      
      
      if (@available(iOS 11.0, *)) {
        inset = self.containerView.safeAreaInsets.bottom;
        [self.popView addSubview:self.compensationView];
        [self.compensationView setFrame:CGRectMake(0, self.popView.frame.size.height, self.containerView.frame.size.width, inset)];
        self.compensationView.backgroundColor = self.popView.backgroundColor;
      }
      self.showOrigin = CGPointMake(0, self.containerView.frame.size.height - self.popView.frame.size.height - inset);
      
      self.endOrigin = self.beginningOrigin;
      
      self.showAnimationDuration = self.popView.frame.size.height / self.showAnimationSpeed;
      self.hideAnimationDuration = self.popView.frame.size.height / self.hideAnimationSpeed;
      break;
    
    case YRDPopViewPopDirectionBelowToCenter:
      self.beginningOrigin = CGPointMake(self.containerView.frame.size.width / 2 - self.popView.frame.size.width / 2, CGRectGetMaxY(self.containerView.frame));
      
      self.showOrigin = CGPointMake(self.containerView.frame.size.width / 2 - self.popView.frame.size.width / 2, self.containerView.frame.size.height / 2 - self.popView.frame.size.height / 2);
      
      self.endOrigin = self.beginningOrigin;
      
      self.showAnimationDuration = self.popView.frame.size.height / self.showAnimationSpeed;
      self.hideAnimationDuration = self.popView.frame.size.height / self.hideAnimationSpeed;
      break;
      
    case YRDPopViewPopDirectionCenter:
      self.beginningOrigin = CGPointMake(CGRectGetMaxX(self.containerView.frame), self.containerView.frame.size.height / 2 - self.popView.frame.size.height / 2);
      
      self.showOrigin = CGPointMake(self.containerView.frame.size.width / 2 - self.popView.frame.size.width / 2, self.containerView.frame.size.height / 2 - self.popView.frame.size.height / 2);
      
      self.endOrigin = CGPointMake(- CGRectGetMaxX(self.containerView.frame), self.containerView.frame.size.height / 2 - self.popView.frame.size.height / 2);
      break;
      
    case YRDPopViewPopDirectionFillFullScreen:
      self.beginningOrigin = CGPointZero;
      self.showOrigin = CGPointZero;
      self.endOrigin = CGPointZero;
      break;
      
    case YRDPopViewPopDirectionFade:
      self.popViewAlphaStates = @[@(0), @(1), @(0)];
      self.beginningOrigin = CGPointMake(self.containerView.frame.size.width / 2 - self.popView.frame.size.width / 2, self.containerView.frame.size.height / 2 - self.popView.frame.size.height / 2);
      
      self.showOrigin = self.beginningOrigin;
      self.endOrigin = self.beginningOrigin;
      
      break;
      
    case YRDPopViewPopDirectionBelowWithPadding:
      self.beginningOrigin = CGPointMake(self.containerView.frame.size.width / 2 - self.popView.frame.size.width / 2, CGRectGetMaxY(self.containerView.frame));
      if (@available(iOS 11.0, *)) {
        inset = self.containerView.safeAreaInsets.bottom;
      }
      self.showOrigin = CGPointMake(self.beginningOrigin.x, self.containerView.frame.size.height - self.popView.frame.size.height - self.beginningOrigin.x - inset);
      
      self.endOrigin = self.beginningOrigin;
      
      self.showAnimationDuration = self.popView.frame.size.height / self.showAnimationSpeed;
      self.hideAnimationDuration = self.popView.frame.size.height / self.hideAnimationSpeed;
      break;
      
    default:
      break;
  }
}

- (void)setUpUI {
  CGRect newFrame = self.popView.frame;
  newFrame.origin = self.beginningOrigin;
  self.popView.frame = newFrame;
  self.popView.alpha = [self.popViewAlphaStates[0] floatValue];
}

- (void)showAction {
  self.mask.alpha = self.maskAlpha;
  CGRect newFrame = self.popView.frame;
  newFrame.origin = self.showOrigin;
  self.popView.frame = newFrame;
  self.popView.alpha = [self.popViewAlphaStates[1] floatValue];
}

- (void)showCompletionAction {
  self.isAnimating = NO;
  if ([self.delegate respondsToSelector:@selector(popViewHelper:didShowPopView:)]) {
    [self.delegate popViewHelper:self didShowPopView:self.popView];
  }
  
  if (self.finalStatus == YRDPopViewFinalStatusHide) {
    [self hidePopView:YES];
  } else {
    self.finalStatus = YRDPopViewFinalStatusUnset;
  }
}

- (void)hideAction {
  self.mask.alpha = 0;
  CGRect newFrame = self.popView.frame;
  newFrame.origin = self.endOrigin;
  self.popView.frame = newFrame;
  self.popView.alpha = [self.popViewAlphaStates[2] floatValue];
}

- (void)hideCompletionAction {
  self.isAnimating = NO;
  self.isShow = NO;
  self.popView.hidden = YES;
  [self.popView removeFromSuperview];
  
  if ([self.delegate respondsToSelector:@selector(popViewHelper:didHidePopView:)]) {
    [self.delegate popViewHelper:self didHidePopView:self.popView];
  }
  
  [[YRDPopViewManager sharedInstance] deQueue:self];
  
  if (self.finalStatus == YRDPopViewFinalStatusShow) {
    [self showPopView:YES];
  } else {
    self.finalStatus = YRDPopViewFinalStatusUnset;
  }
}

#pragma mark - getter & setter

- (void)setShouldLockTargetView:(BOOL)shouldLockTargetView{
  _shouldAnimatedForShadow = shouldLockTargetView;
  if (shouldLockTargetView) {
    self.strongPopView = self.popView;
  } else {
    self.strongPopView = nil;
  }
}

- (void)setShouldAnimatedForShadow:(BOOL)shouldAnimatedForShadow {
  _shouldAnimatedForShadow = shouldAnimatedForShadow;
  self.popViewShadowOpacity = self.popView.layer.shadowOpacity;
  self.popView.layer.shadowOpacity = 0;
}

- (void)setAnimationStyle:(YRDPopViewPopAnimationStyle)animationStyle {
  _animationStyle = animationStyle;
  switch (animationStyle) {
    case YRDPopViewPopAnimationStyleNormal:
      self.spring = 1;
      self.beginningVelocity = 0;
      self.showAnimationDuration = 0.5;
      self.hideAnimationDuration = 0.5;
      break;
      
    case YRDPopViewPopAnimationStyleSpring:
      self.spring = 0.7;
      self.beginningVelocity = 0;
      self.showAnimationDuration = 0.5;
      self.hideAnimationDuration = 0.5;
      
    default:
      break;
  }
}

#pragma mark - getter & setter

- (UIView *)compensationView {
  if (!_compensationView) {
    _compensationView = [[UIView alloc] initWithFrame:CGRectZero];
  }
  
  return _compensationView;
}

@end
