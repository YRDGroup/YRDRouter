//
//  YRDRouter+ConfigHandle.h
//  YRDRouterDemo
//
//  Created by 李二狗 on 2018/7/4.
//  Copyright © 2018年 李二狗. All rights reserved.
//

#import "YRDRouter.h"

@interface YRDRouter (ConfigHandle)

/**
 根据 获取到的配置文件进行路由注册
 
 @param config 路由表
 */
+ (void)registerURLPatternWithConfig:(NSDictionary *)config;

+ (NSString *)getRouterURLByObjectKey:(NSString *)objectKey;

+ (void)overwriteHandlerByObjectKey:(NSString *)objectKey toObjectHandler:(YRDRouterObjectHandler)handler;

@end
