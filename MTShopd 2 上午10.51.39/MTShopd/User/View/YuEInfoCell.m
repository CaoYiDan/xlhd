//
//  YuEInfoCell.m
//  MTShopd
//
//  Created by 伯爵 on 2019/11/8.
//  Copyright © 2019 MTShopd. All rights reserved.
//

#import "YuEInfoCell.h"

@implementation YuEInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)getDataWithInfo:(YeInfoModel *)model{
    self.timeLab.text = model.create_time;
    if ([model.status isEqualToString:@"1"]) {
        self.moneyLab.text = [NSString stringWithFormat:@"+%@",model.amount];
        self.moneyLab.textColor = mainColor;
    }else{
        self.moneyLab.text = [NSString stringWithFormat:@"-%@",model.amount];
        self.moneyLab.textColor = [UIColor blackColor];
    }
    
    if ([model.type isEqualToString:@"10"]) {
        self.nameLab.text = @"线下购买电池";
    }else if([model.type isEqualToString:@"11"]) {
        self.nameLab.text = @"线上购买电池";
    }else if([model.type isEqualToString:@"20"]) {
        self.nameLab.text = @"线下租用电池";
    }else if([model.type isEqualToString:@"21"]) {
        self.nameLab.text = @"线上租用电池";
    }else if([model.type isEqualToString:@"31"]) {
        self.nameLab.text = @"购买金币";
    }else if([model.type isEqualToString:@"32"]) {
        self.nameLab.text = @"购买天数卡";
    }else{
        self.nameLab.text = @"购买次数卡";
    }
}

@end
