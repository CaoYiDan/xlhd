//
//  HdjlCell.m
//  MTUserd
//
//  Created by 伯爵 on 2020/1/13.
//  Copyright © 2020 MTShopd. All rights reserved.
//

#import "HdjlCell.h"

@implementation HdjlCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)getDataWithInfo:(HdjlModel *)model{
    self.timeLab.text = model.replace_time;
    self.hdzLab.text = model.cabinet_name;
    self.dcbmLab.text = model.to_bms_id;
    self.priceLab.text = model.cabinet_address;
}

@end
