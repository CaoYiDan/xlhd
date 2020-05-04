//
//  YjfkCell.m
//  MTUserd
//
//  Created by 伯爵 on 2019/11/12.
//  Copyright © 2019 MTShopd. All rights reserved.
//

#import "YjfkCell.h"

@implementation YjfkCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)getDataWithInfo:(YjfkInfoModel *)model{
    self.timeLab.text = model.created_at;
    self.contentLab.text = model.content;
}


@end
