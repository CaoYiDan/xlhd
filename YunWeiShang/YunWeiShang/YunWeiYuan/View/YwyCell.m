//
//  YwyCell.m
//  YunWeiShang
//
//  Created by 伯爵 on 2020/2/29.
//  Copyright © 2020 GangMeiTanGongXu. All rights reserved.
//

#import "YwyCell.h"

@implementation YwyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)getDataWithInfo:(YwyListModel *)model{
    self.model = model;
    self.nameLab.text = [NSString stringWithFormat:@"姓名：%@",model.name];
    self.accountLab.text = [NSString stringWithFormat:@"账号：%@",model.phone_number];
    self.createTimeLab.text = [NSString stringWithFormat:@"注册时间：%@",model.created_at];
    self.addressLab.text = [NSString stringWithFormat:@"运维范围：%@",model.address];
    if ([model.status isEqualToString:@"1"]) {
        self.stateLab.text = [NSString stringWithFormat:@"帐号状态：正常"];
        [self.djBtn setTitle:@"冻结" forState:UIControlStateNormal];
    }else{
        self.stateLab.text = [NSString stringWithFormat:@"帐号状态：冻结"];
        [self.djBtn setTitle:@"解冻" forState:UIControlStateNormal];
    }
}

- (IBAction)djBtnClick:(UIButton *)sender {
    if ([sender.titleLabel.text isEqualToString:@"冻结"]) {
        NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
        [param setValue:self.model.phone_number forKey:@"phone_number"];
        NSMutableDictionary *jsonStr = param;
    //NSMutableDictionary *jsonStr = param;
    //NSString *jsonStr = [[Singleton shardeManger]convertToJsonData:param];
        [[DataRequest Manager] postBossDemoWithUrl:[NSString stringWithFormat:@"%@tse/active",base_url] param:jsonStr success:^(NSDictionary *dict){
            if ([dict[@"errorCode"]intValue] == 0) {
                [self.djBtn setTitle:@"解冻" forState:UIControlStateNormal];
                self.stateLab.text = [NSString stringWithFormat:@"帐号状态：冻结"];
                
            }else{
                [[[Singleton shardeManger]getCurrentVC] showHint:dict[@"message"]];
            }
        } fail:^(NSError *error) {
             NSLog(@"%@",error);
        }];
    }else{
        NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
        [param setValue:self.model.phone_number forKey:@"phone_number"];
        NSMutableDictionary *jsonStr = param;
    //NSMutableDictionary *jsonStr = param;
    //NSString *jsonStr = [[Singleton shardeManger]convertToJsonData:param];
        [[DataRequest Manager] postBossDemoWithUrl:[NSString stringWithFormat:@"%@tse/frozen",base_url] param:jsonStr success:^(NSDictionary *dict){
            if ([dict[@"errorCode"]intValue] == 0) {
               
                self.stateLab.text = [NSString stringWithFormat:@"帐号状态：正常"];
                [self.djBtn setTitle:@"冻结" forState:UIControlStateNormal];
            }else{
                [[[Singleton shardeManger]getCurrentVC] showHint:dict[@"message"]];
            }
        } fail:^(NSError *error) {
             NSLog(@"%@",error);
        }];
    }
}


@end
