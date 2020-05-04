//
//  TxTypeViewController.m
//  MTShopd
//
//  Created by 伯爵 on 2020/2/11.
//  Copyright © 2020 MTShopd. All rights reserved.
//

#import "TxTypeViewController.h"
#import "AddPayZhViewController.h"

@interface TxTypeViewController ()

@property (weak, nonatomic) IBOutlet UIButton *zfbBtn;
@property (weak, nonatomic) IBOutlet UIButton *wxBtn;

@end

@implementation TxTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提现方式";
    [self requestData];
}

- (void)requestData{
    [[DataRequest Manager]  postBossDemoWithUrl:[NSString stringWithFormat:@"%@withdraw/channel",base_url] param:nil success:^(NSDictionary *dict) {
        NSLog(@"%@",dict);
        if ([dict[@"errorCode"]intValue] == 0) {
            if ([dict[@"data"][@"1"]intValue] == 0) {
                [self.zfbBtn setTitle:@"创建" forState:UIControlStateNormal];
            }else{
                [self.zfbBtn setTitle:@"编辑" forState:UIControlStateNormal];
            }
            if ([dict[@"data"][@"2"]intValue] == 0) {
                [self.wxBtn setTitle:@"创建" forState:UIControlStateNormal];
            }else{
                [self.wxBtn setTitle:@"编辑" forState:UIControlStateNormal];
            }
        }else{
            [self showHint:dict[@"message"]];
        }
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (IBAction)chooseBtnClick:(UIButton *)sender {
    AddPayZhViewController *addPayZhVC = [[AddPayZhViewController alloc]init];
    if (sender.tag == 100) {
        addPayZhVC.titleStr = @"添加支付宝账号";
        addPayZhVC.idStr = self.zfbBtn.titleLabel.text;
    }else{
        addPayZhVC.titleStr = @"添加微信账号";
        addPayZhVC.idStr = self.wxBtn.titleLabel.text;
    }
    [self.navigationController pushViewController:addPayZhVC animated:YES];
}

@end
