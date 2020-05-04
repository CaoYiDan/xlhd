


//
//  OrderManegerCell.m
//  MTShopd
//
//  Created by 伯爵 on 2020/4/16.
//  Copyright © 2020 MTShopd. All rights reserved.
//

#import "OrderManegerCell.h"

@implementation OrderManegerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)getDataWithInfo:(OrderManagerModel *)model{
    self.nameLab.text = model.user_name;
    self.ordersnLab.text = [NSString stringWithFormat:@"订单编号：%@",model.order_sn];
    self.ordersnLab.text = [NSString stringWithFormat:@"提交时间：%@",model.create_time];
    self.ordersnLab.text = [NSString stringWithFormat:@"订单内容：%@",model.order_type];
    self.priceLab.text = [NSString stringWithFormat:@"￥%@",model.order_price];
    if ([model.order_status isEqualToString:@"0"]) {
        [self.payBtn setTitle:@"未支付" forState:UIControlStateNormal];
    }else{
        [self.payBtn setTitle:@"支付成功" forState:UIControlStateNormal];
    }
}

@end
