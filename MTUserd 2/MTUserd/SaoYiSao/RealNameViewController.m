//
//  RealNameViewController.m
//  MTUserd
//
//  Created by 伯爵 on 2019/12/24.
//  Copyright © 2019 MTShopd. All rights reserved.
//

#import "RealNameViewController.h"
#import "RlsbViewController.h"

@interface RealNameViewController ()

@end

@implementation RealNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"实名认证";
}

- (IBAction)saveAndNextBtnClick:(UIButton *)sender {
    RlsbViewController *rlsbVC = [[RlsbViewController alloc]init];
    [self.navigationController pushViewController:rlsbVC animated:YES];
}

@end
