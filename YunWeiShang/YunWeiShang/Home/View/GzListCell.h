//
//  GzListCell.h
//  YunWeiShang
//
//  Created by 伯爵 on 2020/3/2.
//  Copyright © 2020 GangMeiTanGongXu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GzListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GzListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *sbIdLab;
@property (weak, nonatomic) IBOutlet UILabel *addressLab;
@property (weak, nonatomic) IBOutlet UILabel *msLab;
@property (weak, nonatomic) IBOutlet UIButton *gzclBtn;
@property (nonatomic ,strong)GzListModel *model;

- (void)getDataWithInfo:(GzListModel *)model;

@end

NS_ASSUME_NONNULL_END
