//
//  UIView+YRDBehavior.h
//  yrbApp
//
//  Created by yangdeyi1986 on 2018/3/19.
//  Copyright © 2018年 yirendai. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YRDViewBehaviorProtocol.h"

@interface UIView (YRDBehavior)

@property (nonatomic, strong) id<YRDViewBehaviorProtocol> behavior;

@end
