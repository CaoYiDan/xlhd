//
//  TaskListCell.h
//  YunWeiYuan
//
//  Created by 伯爵 on 2020/2/24.
//  Copyright © 2020 GangMeiTanGongXu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TaskListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *gdNumLab;
@property (weak, nonatomic) IBOutlet UILabel *sbIdLab;
@property (weak, nonatomic) IBOutlet UILabel *addressLab;
@property (weak, nonatomic) IBOutlet UILabel *msLab;
@property (weak, nonatomic) IBOutlet UIButton *gzclBtn;
@property (nonatomic ,strong)TaskListModel *model;

- (void)getDataWithInfo:(TaskListModel *)model;

@end

NS_ASSUME_NONNULL_END
