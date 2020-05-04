//
//  HomeClassCell.m
//  MTShopd
//
//  Created by 伯爵 on 2020/2/17.
//  Copyright © 2020 MTShopd. All rights reserved.
//

#import "HomeClassCell.h"
#import "UserViewController.h"
#import "HomeViewController.h"
#import "QsShViewController.h"
#import "DgManagerViewController.h"
#import "SetViewController.h"
#import "UserInfoViewController.h"
#import "TuiZuManagerViewController.h"
#import "OrderManagerViewController.h"

@implementation HomeClassCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)classBtnClick:(UIButton *)sender {
    if (sender.tag == 100) {
        QsShViewController *qsshVC = [[QsShViewController alloc]init];
        [[[Singleton shardeManger]getCurrentVC].navigationController pushViewController:qsshVC animated:YES];
    }else if (sender.tag == 200){
        HomeViewController *homeVC = [[HomeViewController alloc]init];
        [[[Singleton shardeManger]getCurrentVC].navigationController pushViewController:homeVC animated:YES];
    }else if (sender.tag == 300){
        UserViewController *userManagerVC = [[UserViewController alloc]init];
        [[[Singleton shardeManger]getCurrentVC].navigationController pushViewController:userManagerVC animated:YES];
    }else if (sender.tag == 400){
        UserInfoViewController *userInfoVC = [[UserInfoViewController alloc]init];
        [[[Singleton shardeManger]getCurrentVC].navigationController pushViewController:userInfoVC animated:YES];
    }else if (sender.tag == 600){
        OrderManagerViewController *orderManagerVC = [[OrderManagerViewController alloc]init];
        [[[Singleton shardeManger]getCurrentVC].navigationController pushViewController:orderManagerVC animated:YES];
    }else if (sender.tag == 700){
        Toast(@"开发中....");
        return;
        TuiZuManagerViewController *tzManagerVC = [[TuiZuManagerViewController alloc]init];
        [[[Singleton shardeManger]getCurrentVC].navigationController pushViewController:tzManagerVC animated:YES];
    }else if (sender.tag == 800){
        DgManagerViewController *dgManagerVC = [[DgManagerViewController alloc]init];
        [[[Singleton shardeManger]getCurrentVC].navigationController pushViewController:dgManagerVC animated:YES];
    }else if (sender.tag == 1100){
        SetViewController *setVC = [[SetViewController alloc]init];
        [[[Singleton shardeManger]getCurrentVC].navigationController pushViewController:setVC animated:YES];
    }
}

@end
