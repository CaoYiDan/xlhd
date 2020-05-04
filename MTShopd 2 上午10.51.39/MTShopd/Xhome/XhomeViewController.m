//
//  XhomeViewController.m
//  MTShopd
//
//  Created by 伯爵 on 2020/2/13.
//  Copyright © 2020 MTShopd. All rights reserved.
//

#import "XhomeViewController.h"
#import "XhomeTopView.h"
#import "RevenueCell.h"
#import "HomeSecondCell.h"
#import "HomeClassCell.h"
#import "HomeTopModel.h"
#import "HomeSyModel.h"
#import "UserViewController.h"

@interface XhomeViewController ()

@property (nonatomic ,strong)HomeTopModel *model;
@property (nonatomic ,strong)XhomeTopView *topView;
@property (nonatomic ,strong)HomeSyModel *syModel;

@end

static NSString *const revenueCell = @"RevenueCell";
static NSString *const homeSecondCell = @"HomeSecondCell";
static NSString *const homeClassCell = @"HomeClassCell";
@implementation XhomeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
//    UserViewController *vc = [[UserViewController alloc]init];
//    [self.navigationController pushViewController:vc animated:YES];
//    return;
    
    self.title = @"小鹿换电商家";
    //[self createTableView];
    [self setupView];
    
    [self requestData];
    [self requestShopInfoData];
    [self requestSyClassData];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self requestData];
//    [self requestShopInfoData];
//    [self requestSyClassData];
}

- (void)setupView{
    self.topView = [XhomeTopView loadFromNIB];
    self.tableView.tableHeaderView = self.topView;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([RevenueCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:revenueCell];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HomeSecondCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:homeSecondCell];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HomeClassCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:homeClassCell];
}

- (void)requestData{
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
//    [param setValue:@"10" forKey:@"limit"];
//    [param setValue:@"1" forKey:@"page"];
    NSMutableDictionary *jsonStr = param;
//     NSMutableDictionary *jsonStr = param;
//    NSString *jsonStr = [[Singleton shardeManger]convertToJsonData:param];
    [[DataRequest Manager]  postBossDemoWithUrl:[NSString stringWithFormat:@"%@merchant/wallet",base_url] param:jsonStr success:^(NSDictionary *dict) {
        if ([dict[@"errorCode"]intValue] == 0) {
//            self.dataArray = [NSArray yy_modelArrayWithClass:[DgManagerModel class] json:dict[@"data"]];
            self.model = [HomeTopModel yy_modelWithJSON:dict[@"data"]];
            self.topView.totalMoneyLab.text = self.model.balance;
            self.topView.txMoneyLab.text = self.model.withdrawn;
            [self.tableView reloadData];
        }else{
            [self showHint:dict[@"message"]];
        }
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)requestShopInfoData{
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
//    [param setValue:@"10" forKey:@"limit"];
//    [param setValue:@"1" forKey:@"page"];
     NSMutableDictionary *jsonStr = param;
//    NSString *jsonStr = [[Singleton shardeManger]convertToJsonData:param];
    [[DataRequest Manager]  postBossDemoWithUrl:[NSString stringWithFormat:@"%@merchant",base_url] param:jsonStr success:^(NSDictionary *dict) {
        if ([dict[@"errorCode"]intValue] == 0) {
            [self.topView.ewmImg sd_setImageWithURL:[NSURL URLWithString:dict[@"data"][@"qr_code"]] placeholderImage:[UIImage imageNamed:@""]];
            self.title = dict[@"data"][@"name"];
//            [self.tableView reloadData];
        }else{
            [self showHint:dict[@"message"]];
        }
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)requestSyClassData{
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
//    [param setValue:@"10" forKey:@"limit"];
//    [param setValue:@"1" forKey:@"page"];
     NSMutableDictionary *jsonStr = param;
//    NSString *jsonStr = [[Singleton shardeManger]convertToJsonData:param];
    [[DataRequest Manager]  postBossDemoWithUrl:[NSString stringWithFormat:@"%@bill/income-statistics",base_url] param:jsonStr success:^(NSDictionary *dict) {
        if ([dict[@"errorCode"]intValue] == 0) {
            
            self.syModel = [HomeSyModel yy_modelWithJSON:dict[@"data"]];
            [self.tableView reloadData];
            
        }else{
            
            [self showHint:dict[@"message"]];
        }
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        RevenueCell *cell = [RevenueCell loadFromNIB];
        if (!cell) {
            cell = [[RevenueCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:revenueCell];
        }
        cell.totalSrLab.text = [NSString stringWithFormat:@"营业收入总额：%@元",self.model.total];
        [cell getDataWithInfo:self.syModel];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row == 1){
        HomeSecondCell *cell = [HomeSecondCell loadFromNIB];
        if (!cell) {
            cell = [[HomeSecondCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:homeSecondCell];
        }
        [cell getDataWithInfo:self.syModel];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        HomeClassCell *cell = [HomeClassCell loadFromNIB];
        if (!cell) {
            cell = [[HomeClassCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:homeClassCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 170;
    }else if (indexPath.row == 1){
        return 72;
    }else{
        return 280;
    }
}


@end
