//
//  YwyCell.h
//  YunWeiShang
//
//  Created by 伯爵 on 2020/2/29.
//  Copyright © 2020 GangMeiTanGongXu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YwyListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YwyCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *accountLab;
@property (weak, nonatomic) IBOutlet UILabel *createTimeLab;
@property (weak, nonatomic) IBOutlet UILabel *addressLab;
@property (weak, nonatomic) IBOutlet UILabel *stateLab;
@property (weak, nonatomic) IBOutlet UIButton *djBtn;
@property (nonatomic ,strong)YwyListModel *model;

- (void)getDataWithInfo:(YwyListModel *)model;

@end

NS_ASSUME_NONNULL_END
