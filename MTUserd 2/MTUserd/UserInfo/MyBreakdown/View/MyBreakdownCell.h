//
//  MyBreakdownCell.h
//  MTUserd
//
//  Created by 伯爵 on 2019/11/15.
//  Copyright © 2019 MTShopd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyBreakdownModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MyBreakdownCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *stateLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *dcbmLab;
@property (weak, nonatomic) IBOutlet UILabel *gzmsLab;
@property (weak, nonatomic) IBOutlet UILabel *addressLab;
@property (weak, nonatomic) IBOutlet UIImageView *photoImg;

- (void)getDataWithInfo:(MyBreakdownModel *)model;

@end

NS_ASSUME_NONNULL_END
