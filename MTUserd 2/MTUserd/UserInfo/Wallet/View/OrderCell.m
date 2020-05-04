//
//  OrderCell.m
//  MTUserd
//
//  Created by 伯爵 on 2020/1/8.
//  Copyright © 2020 MTShopd. All rights reserved.
//

#import "OrderCell.h"

@implementation OrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)getDataWithInfo:(OrderModel *)model{
    self.timeLab.text = model.created_at;
    self.dcbmLab.text = model.order_amount;
    self.orderXmLab.text = model.goods[0][@"goods_name"];
    self.orderSnLab.text = model.order_sn;
}

@end
