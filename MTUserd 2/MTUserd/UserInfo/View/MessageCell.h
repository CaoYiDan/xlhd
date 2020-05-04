//
//  MessageCell.h
//  MTYunWeiYuan
//
//  Created by 伯爵 on 2019/11/9.
//  Copyright © 2019 MTShopd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MessageCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;

- (void)getDataWithInfo:(MessageModel *)model;

@end

NS_ASSUME_NONNULL_END
