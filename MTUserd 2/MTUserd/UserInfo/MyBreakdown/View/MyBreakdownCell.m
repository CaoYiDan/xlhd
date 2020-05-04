//
//  MyBreakdownCell.m
//  MTUserd
//
//  Created by 伯爵 on 2019/11/15.
//  Copyright © 2019 MTShopd. All rights reserved.
//

#import "MyBreakdownCell.h"

@implementation MyBreakdownCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)getDataWithInfo:(MyBreakdownModel *)model{
    self.dcbmLab.text = model.ticket_sn;
    self.gzmsLab.text = model.title;
}

@end
