//
//  YjczViewController.m
//  MTUserd
//
//  Created by 伯爵 on 2019/12/24.
//  Copyright © 2019 MTShopd. All rights reserved.
//

#import "YjczViewController.h"
#import "RealNameViewController.h"

@interface YjczViewController ()

@end

@implementation YjczViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"押金充值";
}

- (IBAction)goTopupBtnClick:(UIButton *)sender {
    RealNameViewController *realNameVC = [[RealNameViewController alloc]init];
    [self.navigationController pushViewController:realNameVC animated:YES];
}


@end
