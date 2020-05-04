//
//  HomeCell.m
//  MTShopd
//
//  Created by 伯爵 on 2019/11/7.
//  Copyright © 2019 MTShopd. All rights reserved.
//

#import "HomeCell.h"

@implementation HomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)getDataWithInfo:(HomeUserManegerModel *)model{
    self.dcbmLab.text = model.bms_id;
    self.bdsjLab.text = model.bind_user;
    if (![model.bind_user isEqualToString:@""]) {
        self.bdsjLab.text = model.bind_user;
        self.jbBtn.hidden = NO;
    }else{
        self.jbBtn.hidden = YES;
    }
    if (model.battery_status == 1) {
        self.stateLab.text = @"正常";
    }else{
        self.stateLab.text = @"故障";
    }
}

@end
