//
//  HomeDetailCell.h
//  YunWeiYuan
//
//  Created by 伯爵 on 2020/2/24.
//  Copyright © 2020 GangMeiTanGongXu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *firstLab;
@property (weak, nonatomic) IBOutlet UILabel *dgNumLab;
@property (weak, nonatomic) IBOutlet UILabel *dlLab;
@property (weak, nonatomic) IBOutlet UILabel *dianliuLab;
@property (weak, nonatomic) IBOutlet UILabel *dianyaLab;
@property (weak, nonatomic) IBOutlet UILabel *wenduLab;
@property (weak, nonatomic) IBOutlet UILabel *socLab;
@property (weak, nonatomic) IBOutlet UILabel *sohLab;
@property (weak, nonatomic) IBOutlet UILabel *syrlLab;
@property (weak, nonatomic) IBOutlet UILabel *ycLab;
@property (weak, nonatomic) IBOutlet UILabel *dcrjLab;

@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UIView *view4;
@property (weak, nonatomic) IBOutlet UIView *view5;
@property (weak, nonatomic) IBOutlet UIView *view6;
@property (weak, nonatomic) IBOutlet UIView *view7;
@property (weak, nonatomic) IBOutlet UIView *view8;
@property (weak, nonatomic) IBOutlet UIView *view9;


- (void)getDataWithInfo:(DetailInfoModel *)model;

@end

NS_ASSUME_NONNULL_END
