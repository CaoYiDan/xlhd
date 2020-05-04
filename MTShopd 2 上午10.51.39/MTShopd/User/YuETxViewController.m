//
//  YuETxViewController.m
//  MTShopd
//
//  Created by 伯爵 on 2020/2/11.
//  Copyright © 2020 MTShopd. All rights reserved.
//

#import "YuETxViewController.h"
#import "TxTypeViewController.h"

@interface YuETxViewController ()

@end

@implementation YuETxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"余额提现";
}

- (IBAction)txTypeBtnClick:(UIButton *)sender {
    TxTypeViewController *txTypeVC = [[TxTypeViewController alloc]init];
    [self.navigationController pushViewController:txTypeVC animated:YES];
}


@end
