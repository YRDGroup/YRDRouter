//
//  YRDPopViewManager.m
//  kjqApp
//
//  Created by yangdeyi1986 on 2018/3/7.
//  Copyright © 2018年 yirendai. All rights reserved.
//

#import "YRDPopViewManager.h"

#import "YRDPopViewHelper.h"
#import "YRDAbstractPopView.h"

@interface YRDPopViewHelperContainer : NSObject

@property (nonatomic, weak) YRDPopViewHelper *popViewHelper;

- (instancetype)initWithPopViewHelper:(YRDPopViewHelper *)popViewHelper;

@end

@implementation YRDPopViewHelperContainer

- (instancetype)initWithPopViewHelper:(YRDPopViewHelper *)popViewHelper {
  self = [super init];
  if (self) {
    self.popViewHelper = popViewHelper;
  }
  
  return self;
}

@end

@interface YRDPopViewManager()

@property (nonatomic, strong) NSMutableArray<YRDPopViewHelperContainer *> *containers;
@property (nonatomic, strong) NSMutableDictionary<NSNumber *, NSMutableArray<YRDPopViewHelper *> *> *priorityQueue;
@property (nonatomic, weak) YRDPopViewHelper *showingPopViewHelper;

@end

@implementation YRDPopViewManager

+ (instancetype)sharedInstance {
  static YRDPopViewManager *sharedInstance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedInstance = [YRDPopViewManager new];
  });
  
  return sharedInstance;
}

#pragma mark - public

- (void)add:(YRDPopViewHelper *)popViewHelper {
  [self clearReleased];
  
  YRDPopViewHelperContainer *container = [[YRDPopViewHelperContainer alloc] initWithPopViewHelper:popViewHelper];
  [self.containers addObject:container];
}

- (void)hideAllFor:(Class)popViewClass {
  for (YRDPopViewHelperContainer *container in self.containers) {
    YRDPopViewHelper *helper = container.popViewHelper;
    if (!helper) {
      continue;
    }
    
    if ([helper.popView isMemberOfClass:popViewClass] &&
        helper.canForceHide) {
      [helper hidePopView:YES];
    }
  }
  
  [self clearReleased];
}

- (void)hideAll {
  for (YRDPopViewHelperContainer *container in self.containers) {
    YRDPopViewHelper *helper = container.popViewHelper;
    if (!helper) {
      continue;
    }
    
    if (helper.canForceHide) {
      [helper hidePopView:YES];
    }
  }
  
  [self clearReleased];
}

- (void)enQueue:(YRDPopViewHelper *)popViewHelper {
  if (!self.showingPopViewHelper) {
    [popViewHelper showPopView:YES];
    self.showingPopViewHelper = popViewHelper;
  } else {
    popViewHelper.shouldLockTargetView = YES;
  }
  
  NSMutableArray<YRDPopViewHelper *> *array = [self.priorityQueue objectForKey:@(popViewHelper.priority)];
  if (!array) {
    array = [NSMutableArray<YRDPopViewHelper *> new];
    [array addObject:popViewHelper];
    [self.priorityQueue setObject:array forKey:@(popViewHelper.priority)];
  } else {
    [array addObject:popViewHelper];
  }
}

- (void)deQueue:(YRDPopViewHelper *)popViewHelper {
  NSMutableArray *array = [self.priorityQueue objectForKey:@(popViewHelper.priority)];
  if ([array containsObject:popViewHelper]) {
    popViewHelper.shouldLockTargetView = NO;
    [array removeObject:popViewHelper];
    self.showingPopViewHelper = nil;
    [self showInQueue];
  }
}

#pragma mark - private

- (void)showInQueue {
  NSMutableArray *array = nil;
  array = [self.priorityQueue objectForKey:@(YRDPopViewPriorityHigh)];
  if (array && [array count] > 0) {
    self.showingPopViewHelper = array.firstObject;
    goto end;
  }
  
  array = [self.priorityQueue objectForKey:@(YRDPopViewPriorityNormal)];
  if (array && [array count] > 0) {
    self.showingPopViewHelper = array.firstObject;
    goto end;
  }
  
  array = [self.priorityQueue objectForKey:@(YRDPopViewPriorityLow)];
  if (array && [array count] > 0) {
    self.showingPopViewHelper = array.firstObject;
    goto end;
  }
  
end:
  [self.showingPopViewHelper showPopView:YES];
  [self.showingPopViewHelper hidePopViewDelayIfNeeded];
}

- (void)clearReleased {
  NSMutableArray *tempArray = [NSMutableArray new];
  
  for (YRDPopViewHelperContainer *container in self.containers) {
    if (!container.popViewHelper) {
      [tempArray addObject:container];
    }
  }
  
  for (YRDPopViewHelperContainer *container in tempArray) {
    [self.containers removeObject:container];
  }
}

#pragma mark - getter & setter

- (NSMutableArray<YRDPopViewHelperContainer *> *)containers {
  if (!_containers) {
    _containers = [NSMutableArray<YRDPopViewHelperContainer *> new];
  }
  
  return _containers;
}

- (NSMutableDictionary <NSNumber *, NSMutableArray<YRDPopViewHelper *> *> *)queue {
  if (!_priorityQueue) {
    _priorityQueue = [NSMutableDictionary<NSNumber *, NSMutableArray<YRDPopViewHelper *> *> new];
  }
  
  return _priorityQueue;
}

@end


