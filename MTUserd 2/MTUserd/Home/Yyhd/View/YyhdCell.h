//
//  YyhdCell.h
//  MTUserd
//
//  Created by 伯爵 on 2019/11/16.
//  Copyright © 2019 MTShopd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeDianGuiModel.h"
#import "GhdcInfoModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface YyhdCell : UITableViewCell<UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *countLab;
@property (weak, nonatomic) IBOutlet UILabel *juliLab;
@property (weak, nonatomic) IBOutlet UILabel *addressLab;
@property (weak, nonatomic) IBOutlet UIButton *yuyueBtn;
@property (weak, nonatomic) IBOutlet UIView *yuyueView;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *juLiLeft;

@property (nonatomic ,strong)HomeDianGuiModel *model;
@property (nonatomic ,strong)GhdcInfoModel *infoModel;


- (void)getDataWithInfo:(HomeDianGuiModel *)model;
//维修站
- (void)getWxzDataWithInfo:(HomeDianGuiModel *)model;
//归还电池
- (void)getGhdcDataWithInfo:(GhdcInfoModel *)model;

@end

NS_ASSUME_NONNULL_END
