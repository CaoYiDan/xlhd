//
//  YuEInfoCell.h
//  MTShopd
//
//  Created by 伯爵 on 2019/11/8.
//  Copyright © 2019 MTShopd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YeInfoModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface YuEInfoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *moneyLab;

- (void)getDataWithInfo:(YeInfoModel *)model;

@end

NS_ASSUME_NONNULL_END
