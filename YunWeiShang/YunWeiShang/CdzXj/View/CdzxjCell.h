//
//  CdzxjCell.h
//  YunWeiShang
//
//  Created by 伯爵 on 2020/2/29.
//  Copyright © 2020 GangMeiTanGongXu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CdzxjModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CdzxjCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *sbIdLab;
@property (weak, nonatomic) IBOutlet UILabel *zdAddressLab;
@property (weak, nonatomic) IBOutlet UILabel *dbStateLab;
@property (weak, nonatomic) IBOutlet UILabel *xjTimeLab;

- (void)getDataWithInfo:(CdzxjModel *)model;

@end

NS_ASSUME_NONNULL_END
