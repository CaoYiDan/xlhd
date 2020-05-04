//
//  UserCell.m
//  MTShopd
//
//  Created by 伯爵 on 2019/11/7.
//  Copyright © 2019 MTShopd. All rights reserved.
//

#import "UserCell.h"

@implementation UserCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)getDataWithInfo:(UserListModel *)model{
    self.model = model;
    self.accountLab.text = model.phone_number;
    self.timeLab.text = model.bind_time;
    if ([model.use_battery_status isEqualToString:@"0"]) {
        self.yajinLab.text = @"未缴纳";
        [self.jyjBtn setTitle:@"交押金" forState:UIControlStateNormal];
    }else{
        self.yajinLab.text = @"已缴纳";
        [self.jyjBtn setTitle:@"退押金" forState:UIControlStateNormal];
    }
}

- (IBAction)jyjBtnClick:(UIButton *)sender {
    if ([self.model.use_battery_status isEqualToString:@"0"]) {
        UIAlertView *alerView = [[UIAlertView alloc]initWithTitle:nil message:@"是否交押金" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alerView show];
    }else{
        UIAlertView *alerView = [[UIAlertView alloc]initWithTitle:nil message:@"是否退押金" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alerView show];
    }
   
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 0) {
        
    }else{
        
      //101 解除绑定
        if (alertView.tag==101) {
            
            NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
            [param setValue:self.model.phone_number forKey:@"phone_number"];
             NSMutableDictionary *jsonStr = param;
//    NSString *jsonStr = [[Singleton shardeManger]convertToJsonData:param];
            [[DataRequest Manager]  postBossDemoWithUrl:[NSString stringWithFormat:@"%@user/unbind",base_url] param:jsonStr success:^(NSDictionary *dict) {
                NSLog(@"%@",dict);
                if ([dict[@"errorCode"]intValue] == 0) {
                    [[[Singleton shardeManger]getCurrentVC] showHint:dict[@"message"]];
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"updateList" object:nil];
                }else{
                    [[[Singleton shardeManger]getCurrentVC] showHint:dict[@"message"]];
                }
            } fail:^(NSError *error) {
                NSLog(@"%@",error);
            }];
        }else{
              //确认交押金
            if ([self.model.use_battery_status isEqualToString:@"0"]) {
                NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
                [param setValue:self.model.phone_number forKey:@"phone_number"];
                 NSMutableDictionary *jsonStr = param;
//    NSString *jsonStr = [[Singleton shardeManger]convertToJsonData:param];
                [[DataRequest Manager]  postBossDemoWithUrl:[NSString stringWithFormat:@"%@user/pay",base_url] param:jsonStr success:^(NSDictionary *dict) {
                    if ([dict[@"errorCode"]intValue] == 0) {
                        self.model.use_battery_status = @"1";
                        self.yajinLab.text = @"已缴纳";
                        [self.jyjBtn setTitle:@"退押金" forState:UIControlStateNormal];
                    }else{
                        [[[Singleton shardeManger]getCurrentVC] showHint:dict[@"message"]];
                    }
                } fail:^(NSError *error) {
                    NSLog(@"%@",error);
                }];
            }else{
                
                //退押金
                NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
                [param setValue:self.model.phone_number forKey:@"phone_number"];
                 NSMutableDictionary *jsonStr = param;
//    NSString *jsonStr = [[Singleton shardeManger]convertToJsonData:param];
                [[DataRequest Manager]  postBossDemoWithUrl:[NSString stringWithFormat:@"%@user/refund",base_url] param:jsonStr success:^(NSDictionary *dict) {
                    if ([dict[@"errorCode"]intValue] == 0) {
                        self.model.use_battery_status = @"0";
                        self.yajinLab.text = @"未缴纳";
                        [self.jyjBtn setTitle:@"交押金" forState:UIControlStateNormal];
                    }else{
                        [[[Singleton shardeManger]getCurrentVC] showHint:dict[@"message"]];
                    }
                } fail:^(NSError *error) {
                    NSLog(@"%@",error);
                }];
            }
        }
        
    }
}

- (IBAction)jbBtnClick:(UIButton *)sender {
    UIAlertView *alerView = [[UIAlertView alloc]initWithTitle:nil message:@"是否解除绑定" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alerView.tag = 101;
    [alerView show];
}



@end
