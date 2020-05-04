//
//  HomeDetailViewController.m
//  YunWeiYuan
//
//  Created by 伯爵 on 2020/2/24.
//  Copyright © 2020 GangMeiTanGongXu. All rights reserved.
//

#import "HomeDetailViewController.h"
#import "HomeDetailCell.h"
#import "HomeDetailView.h"
#import "HomeDetailModel.h"

@interface HomeDetailViewController ()
{
    HomeDetailView *topView;
}
@property (nonatomic ,strong)HomeDetailModel *detailModel;

@end
static NSString *const cellId = @"cellId";
@implementation HomeDetailViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"换电柜详情";
    [self createTableView];
    [self setupView];
    [self requestData];
}

- (void)setupView{
    topView = [HomeDetailView loadFromNIB];
    self.tableView.tableHeaderView = topView;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HomeDetailCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellId];

}

- (void)requestData{
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setValue:self.model.device_code forKey:@"device_code"];
     NSMutableDictionary *jsonStr = param;
//    NSString *jsonStr = [[Singleton shardeManger]convertToJsonData:param];
    [[DataRequest Manager] postBossDemoWithUrl:[NSString stringWithFormat:@"%@cabinet/details",base_url] param:jsonStr success:^(NSDictionary *dict) {
        if ([dict[@"errorCode"]intValue] == 0) {
            self.detailModel = [HomeDetailModel yy_modelWithJSON:dict[@"data"]];
            [self->topView getDataWithInfo:self.detailModel];
            [self.tableView reloadData];
        }else{
            [self showHint:dict[@"message"]];
        }
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.detailModel.ports.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeDetailCell *cell = [HomeDetailCell loadFromNIB];
    if (!cell) {
        cell = [[HomeDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.firstLab.text = [NSString stringWithFormat:@"%ld",indexPath.row+1];
    [cell getDataWithInfo:self.detailModel.ports[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 230;
}

@end
