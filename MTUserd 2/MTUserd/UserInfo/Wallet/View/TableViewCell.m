//
//  TableViewCell.m
//  MTUserd
//
//  Created by 伯爵 on 2020/1/13.
//  Copyright © 2020 MTShopd. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)getDataWithInfo:(HdjlModel *)model{
    self.timeLab.text = model.replace_time;
    self.hdzLab.text = model.name;
    self.dcbmLab.text = model.device_code;
}

@end
