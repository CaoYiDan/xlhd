//
//  GzDetailCell.m
//  YunWeiShang
//
//  Created by 伯爵 on 2020/3/3.
//  Copyright © 2020 GangMeiTanGongXu. All rights reserved.
//

#import "GzDetailCell.h"

@implementation GzDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)getDataWithInfo:(GzDetailModel *)model{
    self.dgbhLab.text = [NSString stringWithFormat:@"电柜编号：%@",model.device_code];
    self.addressLab.text = [NSString stringWithFormat:@"电柜地址：%@",model.cabinet_address];
    self.gzLab.text = [NSString stringWithFormat:@"故 障：故障"];
    self.timeLab.text = [NSString stringWithFormat:@"报警时间：%@",model.create_time];
    
}

@end
