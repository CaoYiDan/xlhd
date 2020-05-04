//
//  HomeDetailCell.m
//  YunWeiYuan
//
//  Created by 伯爵 on 2020/2/24.
//  Copyright © 2020 GangMeiTanGongXu. All rights reserved.
//

#import "HomeDetailCell.h"

@implementation HomeDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupView];
}

- (void)setupView{
    [self.view1 setBorderLineWithColor:RGB(229, 228, 227)];
    [self.view2 setBorderLineWithColor:RGB(229, 228, 227)];
    [self.view3 setBorderLineWithColor:RGB(229, 228, 227)];
    [self.view4 setBorderLineWithColor:RGB(229, 228, 227)];
    [self.view5 setBorderLineWithColor:RGB(229, 228, 227)];
    [self.view6 setBorderLineWithColor:RGB(229, 228, 227)];
    [self.view7 setBorderLineWithColor:RGB(229, 228, 227)];
    [self.view8 setBorderLineWithColor:RGB(229, 228, 227)];
    [self.view9 setBorderLineWithColor:RGB(229, 228, 227)];
}
- (void)getDataWithInfo:(DetailInfoModel *)model{
    self.dgNumLab.text = [NSString stringWithFormat:@"电柜编号：%@",model.port];
    self.dlLab.text = [NSString stringWithFormat:@"%@%%",model.power];
    self.dianliuLab.text = [NSString stringWithFormat:@"%@mA",model.electron_flow];
    self.dianyaLab.text = [NSString stringWithFormat:@"%@mV",model.voltage];
    self.wenduLab.text = [NSString stringWithFormat:@"%@℃",model.temperature];
    self.socLab.text = [NSString stringWithFormat:@"%@%%",model.soc];
    self.sohLab.text = [NSString stringWithFormat:@"%@%%",model.soh];
//    self.syrlLab.text = model.power;
//    self.dcrjLab.text = model.power;

}

@end
