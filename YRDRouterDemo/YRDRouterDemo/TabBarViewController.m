//
//  TabBarViewController.m
//  YRDRouterDemo
//
//  Created by 李二狗 on 2018/7/3.
//  Copyright © 2018年 李二狗. All rights reserved.
//

#import "TabBarViewController.h"
#import "YRDRouter+ConfigHandle.h"
#import "UIColor+YRD.h"
#import "BaseNavigationController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configUI];
    
    [UIApplication sharedApplication].applicationSupportsShakeToEdit = YES;
    [self becomeFirstResponder];
}



- (void)configUI {
    
    UIViewController *firstpage = [YRDRouter objectForURL:[YRDRouter getRouterURLByObjectKey:@"firstPage"]];
    [self addChildVC:firstpage
               title:@"首页"
           imageName:@"tabbar_firstpage"
   selectedImageName:@"tabbar_firstpage_selected"];
    
    UIViewController *product = [YRDRouter objectForURL:[YRDRouter getRouterURLByObjectKey:@"product"]
                                           withUserInfo:@{@"params":  @{@"appType": @"1"}}];
    [self addChildVC:product
               title:@"领券"
           imageName:@"tabbar_product"
   selectedImageName:@"tabbar_product_selected"];
    
    UIViewController *discovery = [YRDRouter objectForURL:[YRDRouter getRouterURLByObjectKey:@"discovery"]
                                             withUserInfo:@{@"badSpellKeyForUrlString":  @"https://www.baidu.com"}];
    [self addChildVC:discovery
               title:@"发现"
           imageName:@"tabbar_discovery"
   selectedImageName:@"tabbar_discovery_selected"];
    
    UIViewController *mine = [YRDRouter objectForURL:[YRDRouter getRouterURLByObjectKey:@"mine"]];
    [self addChildVC:mine
               title:@"我的"
           imageName:@"tabbar_mine"
   selectedImageName:@"tabbar_mine_selected"];
    
    [self dropShadow];
}


- (void)dropShadow {
    [UITabBar appearance].translucent = NO;
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    
    self.tabBar.backgroundImage = [UIImage new];
    self.tabBar.shadowImage = [UIImage new];
    
    self.tabBar.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.tabBar.layer.shadowOffset = CGSizeMake(0, -2);
    self.tabBar.layer.shadowOpacity = 0.2;
}

- (void)addChildVC:(UIViewController *)vc
             title:(NSString *)title
         imageName:(NSString *)imageName
 selectedImageName:(NSString *)selectedImageName {
    
    vc.title = title;
    
    vc.view.backgroundColor = [UIColor whiteColor];
    
    UIImage *image = [UIImage imageNamed:imageName];
    vc.tabBarItem.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    vc.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    vc.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -4);
    vc.tabBarItem.imageInsets = UIEdgeInsetsMake(-1, 0, 1, 0);
    
    UIColor *normalColor = [UIColor YRDColorWithHexString:@"B1B1B1"];
    NSDictionary *normalAttributes = @{NSForegroundColorAttributeName: normalColor};
    [vc.tabBarItem setTitleTextAttributes:normalAttributes forState:UIControlStateNormal];
    
    UIColor *selectedColor = [UIColor YRDColorWithHexString:@"4F4F4F"];
    NSDictionary *selectedAttributes = @{NSForegroundColorAttributeName: selectedColor};
    [vc.tabBarItem setTitleTextAttributes:selectedAttributes forState:UIControlStateSelected];
    
    BaseNavigationController *navVC = [[BaseNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:navVC];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
