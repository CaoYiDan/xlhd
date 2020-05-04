//
//  RevenueCell.m
//  MTShopd
//
//  Created by 伯爵 on 2020/2/13.
//  Copyright © 2020 MTShopd. All rights reserved.
//

#import "RevenueCell.h"

@implementation RevenueCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)getDataWithInfo:(HomeSyModel *)model{
    self.yjzeLab.text = model.b21;
    self.sdcLab.text = model.b11;
    self.yksrLab.text = model.b32;
    self.cksrLab.text = model.b33;
    self.jbsrLab.text = model.b31;

}

@end
