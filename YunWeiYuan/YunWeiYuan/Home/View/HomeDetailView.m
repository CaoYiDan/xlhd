//
//  HomeDetailView.m
//  YunWeiYuan
//
//  Created by 伯爵 on 2020/2/24.
//  Copyright © 2020 GangMeiTanGongXu. All rights reserved.
//

#import "HomeDetailView.h"

@implementation HomeDetailView

- (void)getDataWithInfo:(HomeDetailModel *)model{
    self.dgbhLab.text = [NSString stringWithFormat:@"电柜编号：%@",model.device_code];
//    self.zdlxLab.text = [NSString stringWithFormat:@"站点类型：%@",model.device_code];
    self.zdNameLab.text = [NSString stringWithFormat:@"站点名称：%@",model.cabinet_name];
    self.zdAddressLab.text = [NSString stringWithFormat:@"站点地址：%@",model.address];
    self.yyTimeLab.text = [NSString stringWithFormat:@"营业时间：%@",model.business];
    self.dcNumLab.text = [NSString stringWithFormat:@"充电柜内电池数：%@",model.battery_number];
    self.phoneLab.text = [NSString stringWithFormat:@"联系人电话：%@",model.tel];
}


@end
