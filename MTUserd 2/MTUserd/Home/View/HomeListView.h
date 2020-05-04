//
//  HomeListView.h
//  MTUserd
//
//  Created by 伯爵 on 2020/1/9.
//  Copyright © 2020 MTShopd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeListView : UIView<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic ,strong)NSArray *dataArray;

@end

NS_ASSUME_NONNULL_END
