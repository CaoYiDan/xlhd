//
//  GzfpCell.h
//  YunWeiShang
//
//  Created by 伯爵 on 2020/3/3.
//  Copyright © 2020 GangMeiTanGongXu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FpywyModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface GzfpCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *phoneLab;

- (void)getDataWithInfo:(FpywyModel *)model;

@end

NS_ASSUME_NONNULL_END
