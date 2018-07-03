//
//  UITabBarItem+YRD.m
//  kjqApp
//
//  Created by yangdeyi1986 on 2018/1/29.
//  Copyright © 2018年 yirendai. All rights reserved.
//

#import "UITabBarItem+YRD.h"

@implementation UITabBarItem (YRD)

@dynamic itemImage;

@dynamic selectedItemImage;

@dynamic itemColor;

@dynamic seletedItemColor;


- (void)setItemImage:(NSString *)itemImage {
  UIImage *image = [UIImage imageNamed: itemImage];
  image = [image imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal];
  
  self.image = image;
}

- (void)setSelectedItemImage:(NSString *)selectedItemImage {
  UIImage *image = [UIImage imageNamed: selectedItemImage];
  image = [image imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal];
  
  self.selectedImage = image;
}

- (void)setSeletedItemColor:(UIColor *)seletedItemColor {
  NSMutableDictionary *atts = [NSMutableDictionary dictionary];
  atts[NSForegroundColorAttributeName] = seletedItemColor;
  
  [self setTitleTextAttributes:atts forState:UIControlStateSelected];
}

- (void)setItemColor:(UIColor *)itemColor {
  NSMutableDictionary *atts = [NSMutableDictionary dictionary];
  atts[NSForegroundColorAttributeName] = itemColor;
  
  [self setTitleTextAttributes:atts forState:UIControlStateNormal];
}

@end
