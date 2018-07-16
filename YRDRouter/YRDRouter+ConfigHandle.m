//
//  YRDRouter+ConfigHandle.m
//  YRDRouterDemo
//
//  Created by 李二狗 on 2018/7/4.
//  Copyright © 2018年 李二狗. All rights reserved.
//

#import "YRDRouter+ConfigHandle.h"
#import "YRDRouter+ViewController.h"
#import "YRDRouter+View.h"

#define kYRDRouterURLKey @"url"
#define kYRDRouterObjectNameKey @"objectName"
#define kYRDRouterParamsKey @"params"

@implementation YRDRouter (ConfigHandle)

+ (void)registerURLPatternWithConfig:(NSDictionary *)config
{
    [YRDRouter sharedInstance].config = [config copy];
    [config[@"path"] enumerateKeysAndObjectsUsingBlock:^(NSString *  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSDictionary *params = [self getUrlAndObjectNameWithObjectKey:key];
        [YRDRouter registerURLPattern:params[kYRDRouterURLKey] toObjectHandler:^id(NSDictionary *routerParameters) {
            NSString *classString = params[kYRDRouterObjectNameKey];
            NSArray *objectNameArray = [classString componentsSeparatedByString:@"."];
            NSString *className = [objectNameArray firstObject];
            NSString *type = nil;
            if (objectNameArray.count > 1) {
              type = [objectNameArray lastObject];
            }
            id object;
            if ([className.lowercaseString hasSuffix:@"vc"] || [className.lowercaseString hasSuffix:@"controller"]) {
                object = [YRDRouter vc_initViewControllerWithClassName:className type:type];
            }
            if ([className.lowercaseString hasSuffix:@"view"]) {
                object = [YRDRouter view_initViewWithClassName:className type:type];
            }
            NSDictionary *userInfo = routerParameters[YRDRouterParameterUserInfo];
            [userInfo enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                [object setValue:obj forKey:key];
            }];
            return object;
        }];
    }];
}

+ (void)overwriteHandlerByObjectKey:(NSString *)objectKey toObjectHandler:(YRDRouterObjectHandler)handler
{
     NSDictionary *params = [self getUrlAndObjectNameWithObjectKey:objectKey];
    [YRDRouter deregisterURLPattern:params[kYRDRouterURLKey]];
    [YRDRouter registerURLPattern:params[kYRDRouterURLKey] toObjectHandler:handler];
}

+ (NSString *)getRouterURLByObjectKey:(NSString *)objectKey;
{
    return [self getUrlAndObjectNameWithObjectKey:objectKey][kYRDRouterURLKey];
}

+ (NSString *)getObjectNameByObjectKey:(NSString *)objectKey
{
    return [self getUrlAndObjectNameWithObjectKey:objectKey][kYRDRouterObjectNameKey];
}

+ (NSDictionary *)getObjectMotifyParamsByObjectKey:(NSString *)objectKey
{
    return [self getUrlAndObjectNameWithObjectKey:objectKey][@"parmas"];
}

+ (NSDictionary *)getUrlAndObjectNameWithObjectKey:(NSString *)objectKey
{
    //TODO: 优化参数安全性
    NSAssert(objectKey,@"router config can not be nil");
    NSDictionary *config = [YRDRouter sharedInstance].config;
    NSString *scheme = config[@"scheme"];
    NSDictionary *pathDic = config[@"path"];
    NSDictionary *objectDic = [pathDic valueForKey:objectKey];
    if (!objectDic) {
        NSLog(@"此 Object Key 不存在");
        return nil;
    }
    NSString *RouterURL = [NSString stringWithFormat:@"%@://%@",scheme,objectKey];
    NSString *objectName = objectDic[kYRDRouterObjectNameKey];
    NSDictionary *parmas = [objectDic valueForKey:@"params"];
    if (!parmas) {
        parmas = @{};
    }
    return @{kYRDRouterURLKey:RouterURL,kYRDRouterObjectNameKey:objectName,@"parmas":parmas};
}

+ (id)objectForObjectKey:(NSString *)objectKey {
    return [self objectForObjectKey:objectKey withUserInfo:nil];
}

+ (id)objectForObjectKey:(NSString *)objectKey withUserInfo:(NSDictionary *)userInfo {
    return [self objectForURL:[YRDRouter getRouterURLByObjectKey:objectKey] withUserInfo:userInfo];
}

+ (void)openURLWithObjectKey:(NSString *)objectKey {
    [self openURLWithObjectKey:objectKey completion:nil];
}

+ (void)openURLWithObjectKey:(NSString *)objectKey completion:(void (^)(id result))completion {
    [self openURLWithObjectKey:objectKey withUserInfo:nil completion:completion];
}

+ (void)openURLWithObjectKey:(NSString *)objectKey withUserInfo:(NSDictionary *)userInfo completion:(void (^)(id result))completion {
    [self openURL:[YRDRouter getRouterURLByObjectKey:objectKey] withUserInfo:userInfo completion:completion];
}

+ (BOOL)canOpenURLWithObjectKey:(NSString *)objectKey {
   return [self canOpenURLWithObjectKey:objectKey matchExactly:NO];
}
+ (BOOL)canOpenURLWithObjectKey:(NSString *)objectKey matchExactly:(BOOL)exactly {
   return [self canOpenURL:[YRDRouter getRouterURLByObjectKey:objectKey] matchExactly:exactly];
}
@end
