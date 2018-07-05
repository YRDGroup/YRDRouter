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

/**
 获取路由URL
 
 @param objectKey 路由标志字段
 @return 路由URL
 */
+ (NSString *)getRouterURLByObjectKey:(NSString *)objectKey;

/**
 重写路由回调
 
 @param objectKey 路由标志字段
 @param handler 重写方法
 */
+ (void)overwriteHandlerByObjectKey:(NSString *)objectKey toObjectHandler:(YRDRouterObjectHandler)handler;

/**
 查找谁对某个 URL 感兴趣，如果有的话，返回一个 object
 
 @param objectKey 模块标志单位
 @return 与之相关已初始化的object
 */
+ (id)objectForObjectKey:(NSString *)objectKey;


/**
 查找谁对某个 URL 感兴趣，如果有的话，返回一个 object
 
 @param objectKey  模块标志单位
 @param userInfo 需要传递的参数， setValue_for_key 方式传递
 @return 与之相关已初始化的object
 */
+ (id)objectForObjectKey:(NSString *)objectKey withUserInfo:(NSDictionary *)userInfo;

/**
 *  打开此 URL
 *  会在已注册的 URL -> Handler 中寻找，如果找到，则执行 Handler
 *
 *  @param objectKey 路由标志字段
 */
+ (void)openURLWithObjectKey:(NSString *)objectKey;

/**
 *  打开此 URL，同时当操作完成时，执行额外的代码
 *
 *  @param objectKey 路由标志字段
 *  @param completion URL 处理完成后的 callback，完成的判定跟具体的业务相关
 */
+ (void)openURLWithObjectKey:(NSString *)objectKey completion:(void (^)(id result))completion;

/**
 *  打开此 URL，带上附加信息，同时当操作完成时，执行额外的代码
 *
 *  @param objectKey 路由标志字段
 *  @param userInfo 附加参数
 *  @param completion URL 处理完成后的 callback，完成的判定跟具体的业务相关
 */
+ (void)openURLWithObjectKey:(NSString *)objectKey withUserInfo:(NSDictionary *)userInfo completion:(void (^)(id result))completion;

/**
 *  是否可以打开URL
 *
 *  @param objectKey 路由标志字段
 *  @return 返回BOOL值
 */
+ (BOOL)canOpenURLWithObjectKey:(NSString *)objectKey;
+ (BOOL)canOpenURLWithObjectKey:(NSString *)objectKey matchExactly:(BOOL)exactly;

@end
