//
//  KJQShareMenuPopView.h
//  YRDRouterDemo
//
//  Created by 李二狗 on 2018/7/5.
//  Copyright © 2018年 李二狗. All rights reserved.
//

#import "YRDAbstractPopView.h"

typedef NS_OPTIONS(NSInteger, KJQShareChannel) {
    KJQShareChannelNone = 0,
    KJQShareChannelWXCircle = 1 << 0,
    KJQShareChannelWXFriends = 1 << 1,
    KJQShareChannelCopyLink = 1 << 2,
};

@interface KJQShareMenuPopView : YRDAbstractPopView

@property (nonatomic, assign) KJQShareChannel shareChannel;

@property (weak, nonatomic) IBOutlet UILabel *paramLabel;
@end
