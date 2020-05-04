//
//  HomeListCell.h
//  YunWeiYuan
//
//  Created by 伯爵 on 2020/2/24.
//  Copyright © 2020 GangMeiTanGongXu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HomeListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *bhLab;
@property (weak, nonatomic) IBOutlet UIButton *stateBtn;
@property (weak, nonatomic) IBOutlet UILabel *addressLab;
@property (nonatomic ,strong)HomeListModel *model;

- (void)getDataWithInfo:(HomeListModel *)model;

@end

NS_ASSUME_NONNULL_END
