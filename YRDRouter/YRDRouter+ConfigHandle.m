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

@implementation YRDRouter (ConfigHandle)

/* ag:
 {
 "scheme":"kjqApp",
 "path":{
 "firstPage":{
 "objectName":"KJQFirstPageViewController",
 //"params":{
 //   "keyName":"userInfoName",  命名纠正,此版本不涉及
 //   "keyNameOfVC":"userInfoName",
 //}
 }
 "product":{"objectName":"KJQProductListViewController"},
 }
 
 }
 */
+ (void)registerURLPatternWithConfig:(NSDictionary *)config
{
    [YRDRouter sharedInstance].config = [config copy];
    [config[@"path"] enumerateKeysAndObjectsUsingBlock:^(NSString *  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSDictionary *params = [self getUrlAndObjectNameWithObjectKey:key];
        [YRDRouter registerURLPattern:params[@"url"] toObjectHandler:^id(NSDictionary *routerParameters) {
            NSString *classString = params[@"objectName"];
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
    [YRDRouter registerURLPattern:params[@"url"] toObjectHandler:handler];
}

+ (NSString *)getRouterURLByObjectKey:(NSString *)objectKey;
{
    return [self getUrlAndObjectNameWithObjectKey:objectKey][@"url"];
}

+ (NSString *)getObjectNameByObjectKey:(NSString *)objectKey
{
    return [self getUrlAndObjectNameWithObjectKey:objectKey][@"objectName"];
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
    NSString *objectName = objectDic[@"objectName"];
    return @{@"url":RouterURL,@"objectName":objectName};
}

@end
