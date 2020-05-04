//
//  YjczView.m
//  MTUserd
//
//  Created by 伯爵 on 2020/1/6.
//  Copyright © 2020 MTShopd. All rights reserved.
//

#import "YjczView.h"

@implementation YjczView


- (IBAction)buyBtnClick:(UIButton *)sender {
    TopupDetailViewController *topupDetailVC = [[TopupDetailViewController alloc]init];
    [[[Singleton shardeManger]getCurrentVC].navigationController pushViewController:topupDetailVC animated:YES];
}

@end
