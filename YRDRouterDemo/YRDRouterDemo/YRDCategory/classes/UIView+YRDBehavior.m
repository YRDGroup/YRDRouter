//
//  UIView+YRDBehavior.m
//  yrbApp
//
//  Created by yangdeyi1986 on 2018/3/19.
//  Copyright © 2018年 yirendai. All rights reserved.
//

#import "UIView+YRDBehavior.h"

#import <objc/runtime.h>

@implementation UIView (YRDBehavior)

- (void)setBehavior:(id<YRDViewBehaviorProtocol>)behavior {
  objc_setAssociatedObject(self, @selector(behavior), behavior, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id<YRDViewBehaviorProtocol>)behavior {
  return objc_getAssociatedObject(self, @selector(behavior));
}

@end
