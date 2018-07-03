//
//  YRDViewBehaviorProtocol.h
//  yrbApp
//
//  Created by yangdeyi1986 on 2018/3/19.
//  Copyright © 2018年 yirendai. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIView;

typedef void(^behaviorCompletion)(id result);

@protocol YRDViewBehaviorProtocol <NSObject>

@optional
- (void)loadDataWithCompletion:(behaviorCompletion)completion;
- (void)initView:(UIView *)view;
- (UIView *)view;

@end
