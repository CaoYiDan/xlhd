//
//  GzfpViewController.h
//  YunWeiShang
//
//  Created by 伯爵 on 2020/3/3.
//  Copyright © 2020 GangMeiTanGongXu. All rights reserved.
//

#import "BaseTableViewController.h"
#import "GzListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GzfpViewController : BaseTableViewController

@property (nonatomic ,strong)HomeListModel *model;
@property (nonatomic ,strong)NSString *titleStr;
@property (nonatomic ,strong)GzListModel *gzmodel;

@end

NS_ASSUME_NONNULL_END
