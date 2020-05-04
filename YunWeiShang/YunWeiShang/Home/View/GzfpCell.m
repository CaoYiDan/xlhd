//
//  GzfpCell.m
//  YunWeiShang
//
//  Created by 伯爵 on 2020/3/3.
//  Copyright © 2020 GangMeiTanGongXu. All rights reserved.
//

#import "GzfpCell.h"

@implementation GzfpCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.bgView setBorderLineWithColor:RGB(232, 231, 232)];
}

- (void)getDataWithInfo:(FpywyModel *)model{
    self.nameLab.text = model.name;
    self.phoneLab.text = model.phone_number;
    if (model.selected == YES) {
        self.bgView.backgroundColor = RGB(237, 245, 238);
    }else{
        self.bgView.backgroundColor = [UIColor whiteColor];
    }
}

@end
