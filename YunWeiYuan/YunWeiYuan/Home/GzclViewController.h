//
//  GzclViewController.h
//  YunWeiYuan
//
//  Created by 伯爵 on 2020/2/24.
//  Copyright © 2020 GangMeiTanGongXu. All rights reserved.
//

#import "BaseViewController.h"
#import "TaskListModel.h"
#import "HomeListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GzclViewController : BaseViewController

@property (nonatomic ,strong)TaskListModel *model;
@property (nonatomic ,strong)HomeListModel *homeModel;

@end

NS_ASSUME_NONNULL_END
