//
//  UITabBarItem+YRD.h
//  kjqApp
//
//  Created by yangdeyi1986 on 2018/1/29.
//  Copyright © 2018年 yirendai. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface UITabBarItem (YRD)

@property (nonatomic, strong) IBInspectable NSString *itemImage;

@property (nonatomic, strong) IBInspectable NSString *selectedItemImage;

@property (nonatomic, strong) IBInspectable UIColor *itemColor;

@property (nonatomic, strong) IBInspectable UIColor *seletedItemColor;

@end
