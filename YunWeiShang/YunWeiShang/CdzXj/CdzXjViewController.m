//
//  CdzXjViewController.m
//  YunWeiShang
//
//  Created by 伯爵 on 2020/2/28.
//  Copyright © 2020 GangMeiTanGongXu. All rights reserved.
//

#import "CdzXjViewController.h"
#import "CdzxjCell.h"
#import "CdzxjModel.h"
#import "CdzXjDetailViewController.h"

@interface CdzXjViewController ()

@property (nonatomic ,strong)NSArray *dataArray;

@end
static NSString *const cellId = @"cellId";
@implementation CdzXjViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTableView];
    [self setupView];
    if ([self.titleStr isEqualToString:@"home"]) {
        [self homeRequestData];
        self.title = @"每周巡检";
    }else{
        [self requestData];
    }
}

- (void)setupView{
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CdzxjCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellId];

}

- (void)homeRequestData{
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setValue:@"10" forKey:@"limit"];
    [param setValue:@"1" forKey:@"page"];
    [param setValue:self.model.device_code forKey:@"device_code"];
    NSMutableDictionary *jsonStr = param;
    //NSMutableDictionary *jsonStr = param;
    //NSString *jsonStr = [[Singleton shardeManger]convertToJsonData:param];
    [[DataRequest Manager] postBossDemoWithUrl:[NSString stringWithFormat:@"%@cabinet/checks",base_url] param:jsonStr success:^(NSDictionary *dict) {
        if ([dict[@"errorCode"]intValue] == 0) {
            self.dataArray = [NSArray yy_modelArrayWithClass:[CdzxjModel class] json:dict[@"data"]];
            [self.tableView reloadData];
        }else{
            [self showHint:dict[@"message"]];
        }
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)requestData{
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setValue:@"10" forKey:@"limit"];
    [param setValue:@"1" forKey:@"page"];
//    [param setValue:@"1" forKey:@"status"];
    NSMutableDictionary *jsonStr = param;
    //NSMutableDictionary *jsonStr = param;
    //NSString *jsonStr = [[Singleton shardeManger]convertToJsonData:param];
    [[DataRequest Manager] postBossDemoWithUrl:[NSString stringWithFormat:@"%@check/list",base_url] param:jsonStr success:^(NSDictionary *dict) {
        if ([dict[@"errorCode"]intValue] == 0) {
            self.dataArray = [NSArray yy_modelArrayWithClass:[CdzxjModel class] json:dict[@"data"]];
            [self.tableView reloadData];
        }else{
            [self showHint:dict[@"message"]];
        }
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CdzxjCell *cell = [CdzxjCell loadFromNIB];
    if (!cell) {
        cell = [[CdzxjCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    [cell getDataWithInfo:self.dataArray[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 140;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CdzXjDetailViewController *cdzxjDeatalVC = [[CdzXjDetailViewController alloc]init];
    cdzxjDeatalVC.model = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:cdzxjDeatalVC animated:YES];
}

@end
