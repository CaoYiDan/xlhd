//
//  BaseTableViewController.m
//  Pos
//
//  Created by mac on 2018/8/16.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "BaseTableViewController.h"

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(236, 237, 238);
}

- (void)createTableView{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = RGB(236, 237, 238);
    [self.view addSubview:_tableView];
    
    _tableView.showsVerticalScrollIndicator = NO;
       _tableView.showsHorizontalScrollIndicator = NO;
       _tableView.contentInset = UIEdgeInsetsMake(0, 0, 35, 0);
     __weak typeof(self) weakSelf = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
         [weakSelf refreshData]; // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    // 结束刷新
                    [weakSelf.tableView.mj_header endRefreshing];
                });
    }];
}

-(void)refreshData{
    
}

@end
