//
//  UIView+YRD.m
//  kjqApp
//
//  Created by yangdeyi1986 on 2018/1/29.
//  Copyright © 2018年 yirendai. All rights reserved.
//

#import "UIView+YRD.h"


@implementation UIView (YRD)

@dynamic borderWidth;
@dynamic borderColor;
@dynamic cornerRadius;

- (void)setBorderWidth:(CGFloat)borderWidth {
  if(borderWidth <0) return;
  self.layer.borderWidth = borderWidth;
}

- (void)setBorderColor:(UIColor *)borderColor {
  self.layer.borderColor = borderColor.CGColor;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
  self.layer.cornerRadius = cornerRadius;
  self.layer.masksToBounds = cornerRadius >0;
}

- (CGFloat)top {
  return self.frame.origin.y;
}

- (void)setTop:(CGFloat)top {
  CGRect newFrame = self.frame;
  newFrame.origin.y = top;
  self.frame = newFrame;
}

- (CGFloat)bottom {
  return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
  CGRect newFrame = self.frame;
  newFrame.size.height = bottom - self.frame.origin.y;
  self.frame = newFrame;
}

- (CGFloat)left {
  return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)left {
  CGRect newFrame = self.frame;
  newFrame.origin.x = left;
  self.frame = newFrame;
}

- (CGFloat)right {
  return self.frame.size.width + self.frame.origin.x;
}

- (void)setRight:(CGFloat)right {
  CGRect newFrame = self.frame;
  newFrame.size.width = right - self.frame.origin.x;
  self.frame = newFrame;
}

- (void)setWidth:(CGFloat)width {
  CGRect newFrame = self.frame;
  newFrame.size.width = width;
  self.frame = newFrame;
}

- (CGFloat)width {
  return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height {
  CGRect newFrame = self.frame;
  newFrame.size.height = height;
  self.frame = newFrame;
}

- (CGFloat)height {
  return self.frame.size.height;
}

- (void)setX:(CGFloat)x {
  CGRect frame = self.frame;
  frame.origin.x = x;
  self.frame = frame;
}

- (void)setY:(CGFloat)y {
  CGRect frame = self.frame;
  frame.origin.y = y;
  self.frame = frame;
}

- (CGFloat)x {
  return self.frame.origin.x;
}

- (CGFloat)y {
  return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX {
  CGPoint center = self.center;
  center.x = centerX;
  self.center = center;
}

- (CGFloat)centerX {
  return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY {
  CGPoint center = self.center;
  center.y = centerY;
  self.center = center;
}

- (CGFloat)centerY {
  return self.center.y;
}

+ (UIView *)loadFromNib {
  UINib *nib = [UINib nibWithNibName:NSStringFromClass(self) bundle:[NSBundle mainBundle]];
  return [nib instantiateWithOwner:nil options:nil].firstObject;
}

+ (UINib *)nib {
  UINib *nib = [UINib nibWithNibName:NSStringFromClass(self) bundle:[NSBundle mainBundle]];
  return nib;
}

- (UIViewController *)viewController {
  UIResponder *nextResponder = self.nextResponder;
  while (nextResponder) {
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
      return (UIViewController *)nextResponder;
    }
    
    nextResponder = nextResponder.nextResponder;
  }
  
  return NULL;
}

- (UITapGestureRecognizer *)kjq_addTapGestureTarget:target action:(SEL)action {
  UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
  self.userInteractionEnabled = YES;
  [self addGestureRecognizer:tgr];
  return tgr;
}
@end
