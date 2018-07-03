//
//  YRDRouter+ViewController.m
//  YRDRouterDemo
//
//  Created by 李二狗 on 2018/7/3.
//  Copyright © 2018年 李二狗. All rights reserved.
//

#import "YRDRouter+ViewController.h"


@implementation YRDRouter (ViewController)

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
            id object = [[NSClassFromString(params[@"objectName"]) alloc] init];
            NSDictionary *userInfo = routerParameters[YRDRouterParameterUserInfo];
            [userInfo enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                [object setValue:object forKey:key];
            }];
            return object;
        }];
    }];  
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
