//
//  YjfkViewController.m
//  MTUserd
//
//  Created by 伯爵 on 2019/11/12.
//  Copyright © 2019 MTShopd. All rights reserved.
//

#import "YjfkViewController.h"
#import "YjfkCell.h"
#import "XfkViewController.h"
#import "YjfkInfoModel.h"

@interface YjfkViewController ()

@property (nonatomic ,strong)NSArray *dataArray;

@end
static NSString *const cellId = @"cellId";
@implementation YjfkViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"意见反馈";
    //[self createTableView];
    [self setupView];
}

- (void)setupView{
    
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"写反馈" style:UIBarButtonItemStylePlain target:self action:@selector(rightBtn)];
    self.navigationItem.rightBarButtonItem = rightBarItem;

    self.tableView.estimatedRowHeight = 500;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YjfkCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellId];
}

- (void)requestData{
    [[DataRequest Manager]  postBossDemoWithUrl:[NSString stringWithFormat:@"%@feedback/feedback-list",base_url] param:nil success:^(NSDictionary *dict) {
        if ([dict[@"errorCode"]intValue] == 0) {
            self.dataArray = [NSArray yy_modelArrayWithClass:[YjfkInfoModel class] json:dict[@"data"]];
            [self.tableView reloadData];
        }else{
            [self showHint:dict[@"message"]];
        }
    } fail:^(NSError *error) {
    }];
}

- (void)rightBtn{
    XfkViewController *xfkVC = [[XfkViewController alloc]init];
    [self.navigationController pushViewController:xfkVC animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YjfkCell *cell = [YjfkCell loadFromNIB];
    if (!cell) {
        cell = [[YjfkCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    [cell getDataWithInfo:self.dataArray[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 500;
//}


@end
