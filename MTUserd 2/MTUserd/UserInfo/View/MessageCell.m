//
//  MessageCell.m
//  MTYunWeiYuan
//
//  Created by 伯爵 on 2019/11/9.
//  Copyright © 2019 MTShopd. All rights reserved.
//

#import "MessageCell.h"

@implementation MessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)getDataWithInfo:(MessageModel *)model{
    self.titleLab.text = model.title;
    self.timeLab.text = model.created_at;
    self.contentLab.text = model.content;
}

@end
