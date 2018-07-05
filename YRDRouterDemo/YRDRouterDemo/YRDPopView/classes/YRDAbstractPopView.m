//
//  YRDAbstractPopView.m
//  kjqApp
//
//  Created by yangdeyi1986 on 2018/3/6.
//  Copyright © 2018年 yirendai. All rights reserved.
//

#import "YRDAbstractPopView.h"

@interface YRDAbstractPopView()

@end

@implementation YRDAbstractPopView

- (instancetype)initWithSize:(CGSize)size direciton:(YRDPopViewPopDirection)direction maskStatus:(YRDPopViewMaskStatus)maskStatus {
  self = [super initWithFrame:CGRectZero];
  if (self) {
    [self initPopViewHelperWithSize:size direciton:direction maskStatus:maskStatus];
  }
  
  return self;
}

- (void)initPopViewHelperWithSize:(CGSize)size direciton:(YRDPopViewPopDirection)direction maskStatus:(YRDPopViewMaskStatus)maskStatus {
  [self setFrame:CGRectMake(0, 0, size.width, size.height)];
  self.helper = [[YRDPopViewHelper alloc] initWithContainerView:nil popView:self direction:direction maskStatus:maskStatus];
}

- (void)show {
  [self.helper showPopView:YES];
}

- (void)hide {
  [self.helper hidePopView:YES];
}

- (void)autoHidePopViewAfter:(NSTimeInterval)delayTime {
  [self.helper hidePopViewAfterDelayTime:delayTime];
}

- (void)toggle {
  if (self.helper.isShow) {
    [self.helper hidePopView:YES];
  } else {
    [self.helper showPopView:YES];
  }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
  UIView *view = [super hitTest:point withEvent:event];
  if (view && view == self) {
    return nil;
  }
  
  return view;
}

@end
