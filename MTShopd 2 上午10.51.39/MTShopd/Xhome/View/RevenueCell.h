//
//  RevenueCell.h
//  MTShopd
//
//  Created by 伯爵 on 2020/2/13.
//  Copyright © 2020 MTShopd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeSyModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface RevenueCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *totalSrLab;
@property (weak, nonatomic) IBOutlet UILabel *yjzeLab;
@property (weak, nonatomic) IBOutlet UILabel *sdcLab;
@property (weak, nonatomic) IBOutlet UILabel *cksrLab;
@property (weak, nonatomic) IBOutlet UILabel *yksrLab;
@property (weak, nonatomic) IBOutlet UILabel *jbsrLab;

- (void)getDataWithInfo:(HomeSyModel *)model;

@end

NS_ASSUME_NONNULL_END
