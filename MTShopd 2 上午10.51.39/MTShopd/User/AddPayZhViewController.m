//
//  AddPayZhViewController.m
//  MTShopd
//
//  Created by 伯爵 on 2020/2/11.
//  Copyright © 2020 MTShopd. All rights reserved.
//

#import "AddPayZhViewController.h"

@interface AddPayZhViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *accountLab;


@end

@implementation AddPayZhViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.titleStr;
}

- (IBAction)addBtnClick:(UIButton *)sender {
//    if ([self.titleStr isEqualToString:@"添加支付宝账号"]) {
        if ([self.idStr isEqualToString:@"创建"]) {
            NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
            [param setValue:self.nameTF.text forKey:@"name"];
            [param setValue:self.accountLab.text forKey:@"channel_account"];
             NSMutableDictionary *jsonStr = param;
//    NSString *jsonStr = [[Singleton shardeManger]convertToJsonData:param];
            [[DataRequest Manager]  postBossDemoWithUrl:[NSString stringWithFormat:@"%@withdraw/create-channel",base_url] param:jsonStr success:^(NSDictionary *dict) {
                if ([dict[@"errorCode"]intValue] == 0) {
                    [self.navigationController popViewControllerAnimated:YES];
                }else{
                    [self showHint:dict[@"message"]];
                }
            } fail:^(NSError *error) {
                NSLog(@"%@",error);
            }];
        }else{
            NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
            [param setValue:self.nameTF.text forKey:@"name"];
            [param setValue:self.accountLab.text forKey:@"channel_account"];
             NSMutableDictionary *jsonStr = param;
//    NSString *jsonStr = [[Singleton shardeManger]convertToJsonData:param];
            [[DataRequest Manager]  postBossDemoWithUrl:[NSString stringWithFormat:@"%@withdraw/update-channel",base_url] param:jsonStr success:^(NSDictionary *dict) {
                if ([dict[@"errorCode"]intValue] == 0) {
                    [self.navigationController popViewControllerAnimated:YES];
                }else{
                    [self showHint:dict[@"message"]];
                }
            } fail:^(NSError *error) {
                NSLog(@"%@",error);
            }];
        }
//    }
}

@end
