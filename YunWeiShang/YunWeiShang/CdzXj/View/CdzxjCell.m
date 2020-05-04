//
//  CdzxjCell.m
//  YunWeiShang
//
//  Created by 伯爵 on 2020/2/29.
//  Copyright © 2020 GangMeiTanGongXu. All rights reserved.
//

#import "CdzxjCell.h"

@implementation CdzxjCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)getDataWithInfo:(CdzxjModel *)model{
    self.sbIdLab.text = [NSString stringWithFormat:@"设备ID：%@",model.check_id];
    self.zdAddressLab.text = [NSString stringWithFormat:@"站点地址：%@",model.check_id];
    self.sbIdLab.text = [NSString stringWithFormat:@"巡检时间：%@",model.created_at];
    if ([model.status isEqualToString:@"1"]) {
        self.dbStateLab.text = [NSString stringWithFormat:@"电板状态：正常"];
    }else{
        self.dbStateLab.text = [NSString stringWithFormat:@"电板状态：故障"];
    }

}

@end
