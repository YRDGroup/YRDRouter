//
//  KJQShareMenuPopView.m
//  YRDRouterDemo
//
//  Created by 李二狗 on 2018/7/5.
//  Copyright © 2018年 李二狗. All rights reserved.
//

#import "KJQShareMenuPopView.h"

@interface KJQShareMenuPopView ()<YRDPopViewHelperDelegate>

@end

@implementation KJQShareMenuPopView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self initPopViewHelperWithSize:CGSizeMake([[UIScreen mainScreen] bounds].size.width, 210)
                          direciton:YRDPopViewPopDirectionBelow
                         maskStatus:YRDPopViewMaskStatusNormal];
    self.helper.delegate = self;
    
  
}

- (void)setShareChannel:(KJQShareChannel)shareChannel {
    _shareChannel = shareChannel;
    self.paramLabel.text = [NSString stringWithFormat:@"%ld",(long)self.shareChannel];
}


#pragma mark - YRDPopViewHelperDelegate

- (void)popViewHelper:(YRDPopViewHelper *)popViewHelper willShowPopView:(YRDAbstractPopView *)popView {

}

- (void)popViewHelper:(YRDPopViewHelper *)popViewHelper willHidePopView:(YRDAbstractPopView *)popView {
   
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
