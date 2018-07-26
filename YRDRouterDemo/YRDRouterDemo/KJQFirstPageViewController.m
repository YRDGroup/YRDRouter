//
//  KJQFirstPageViewController.m
//  YRDRouterDemo
//
//  Created by 李二狗 on 2018/7/3.
//  Copyright © 2018年 李二狗. All rights reserved.
//

#import "KJQFirstPageViewController.h"
#import "YRDRouter+ConfigHandle.h"
#import "OverwriteViewController.h"
#import "KJQShareMenuPopView.h"
@interface KJQFirstPageViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *titleArray;
@end

@implementation KJQFirstPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleArray = @[@"router normal VC",@"router Xib VC with params",@"router SB VC",@"overwrite:click this row then click row 0 ",@"KJQShareMenuPopView",@"wait",@"wait",@"wait"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellIndetifier"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
   UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIndetifier" forIndexPath:indexPath];
    cell.textLabel.text = self.titleArray[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIViewController *vc;
    switch (indexPath.row) {
        case 0:
        {
            vc =  [YRDRouter objectForObjectKey:@"normal"];

        }
            break;
        case 1:
        {
            vc = [YRDRouter objectForObjectKey:@"discovery" withUserInfo:@{@"badSpellKeyForUrlString":  @"https://www.baidu.com"}];
        }
            break;
        case 2:
        {
            vc = [YRDRouter objectForObjectKey:@"feedback"];
        }
            break;
        case 3:
        {
            [YRDRouter overwriteHandlerByObjectKey:@"normal" toObjectHandler:^id(NSDictionary *routerParameters) {
                OverwriteViewController *vc = [[OverwriteViewController alloc]init];
                return vc;
            }];
        }
            break;
        case 4:
        {
            KJQShareMenuPopView *popView =  [YRDRouter objectForObjectKey:@"share" withUserInfo:@{@"shareChannel":  @(KJQShareChannelCopyLink | KJQShareChannelWXCircle | KJQShareChannelWXFriends)}];
            [popView show];
        }
            break;
            
        default:
        {
              vc = [YRDRouter objectForObjectKey:kDefaultErrorRouterKey];
        }
            break;
    }
    
    if (!vc) {
        return;
    }
    vc.navigationItem.title = self.titleArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:vc];
    
}


@end
