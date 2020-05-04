//
//  GzDetailCell.h
//  YunWeiShang
//
//  Created by 伯爵 on 2020/3/3.
//  Copyright © 2020 GangMeiTanGongXu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GzDetailModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface GzDetailCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *dgbhLab;
@property (weak, nonatomic) IBOutlet UILabel *zdIdLab;
@property (weak, nonatomic) IBOutlet UILabel *addressLab;
@property (weak, nonatomic) IBOutlet UILabel *gzLab;
@property (weak, nonatomic) IBOutlet UILabel *gzdmLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;

- (void)getDataWithInfo:(GzDetailModel *)model;

@end

NS_ASSUME_NONNULL_END
