//
//  HomeSecondCell.m
//  MTShopd
//
//  Created by 伯爵 on 2020/2/17.
//  Copyright © 2020 MTShopd. All rights reserved.
//

#import "HomeSecondCell.h"

@implementation HomeSecondCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)getDataWithInfo:(HomeSyModel *)model{
    self.xxyjLab.text = model.b20;
    self.xxsdcLab.text = model.b10;
}

@end
