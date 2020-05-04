//
//  HomeCell.h
//  MTShopd
//
//  Created by 伯爵 on 2019/11/7.
//  Copyright © 2019 MTShopd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeUserManegerModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HomeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *dcbmLab;
@property (weak, nonatomic) IBOutlet UILabel *bdsjLab;
@property (weak, nonatomic) IBOutlet UILabel *stateLab;
@property (weak, nonatomic) IBOutlet UIButton *jbBtn;

- (void)getDataWithInfo:(HomeUserManegerModel *)model;

@end

NS_ASSUME_NONNULL_END
