//
//  HomeViewController.m
//  MTShopd
//
//  Created by 伯爵 on 2019/11/7.
//  Copyright © 2019 MTShopd. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeCell.h"
#import "UserInfoViewController.h"
#import "PYTempViewController.h"
#import "HomeUserManegerModel.h"

@interface HomeViewController ()<PYSearchViewControllerDelegate>

@property (nonatomic ,strong)NSArray *dataArray;

@end
static NSString *const cellId = @"cellId";
@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"电池管理";
    //[self createTableView];
    [self setupView];
    [self requestData];
    
    
}

- (void)setupView{
//    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"消息"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBtn)];
//        self.navigationItem.rightBarButtonItem = rightBarItem;
//    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"我的"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBtn)];
//    self.navigationItem.leftBarButtonItem = leftBarItem;

    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HomeCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellId];

}

- (void)requestData{
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setValue:@"10" forKey:@"limit"];
    [param setValue:@"1" forKey:@"page"];
     NSMutableDictionary *jsonStr = param;
//    NSString *jsonStr = [[Singleton shardeManger]convertToJsonData:param];
    [[DataRequest Manager]  postBossDemoWithUrl:[NSString stringWithFormat:@"%@battery/my-batteries",base_url] param:jsonStr success:^(NSDictionary *dict) {
        if ([dict[@"errorCode"]intValue] == 0) {
            self.dataArray = [NSArray yy_modelArrayWithClass:[HomeUserManegerModel class] json:dict[@"data"]];
            [self.tableView reloadData];
        }else{
            [self showHint:dict[@"message"]];
        }
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

//- (void)rightBtn{
//    
//}
//
//- (void)leftBtn{
//    UserInfoViewController *userInfoVC = [[UserInfoViewController alloc]init];
//    [self.navigationController pushViewController:userInfoVC animated:YES];
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeUserManegerModel *model = self.dataArray[indexPath.row];
    HomeCell *cell = [HomeCell loadFromNIB];
    if (!cell) {
        cell = [[HomeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.jbBtn.tag = indexPath.row;
    [cell.jbBtn addTarget:self action:@selector(jbBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell getDataWithInfo:model];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 142;
}

- (void)jbBtnClick:(UIButton *)sender{
    HomeUserManegerModel *model = self.dataArray[sender.tag];
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setValue:model.bms_id forKey:@"bms_id"];
     NSMutableDictionary *jsonStr = param;
//    NSString *jsonStr = [[Singleton shardeManger]convertToJsonData:param];
    [[DataRequest Manager]  postBossDemoWithUrl:[NSString stringWithFormat:@"%@battery/user-unbind",base_url] param:jsonStr success:^(NSDictionary *dict) {
        if ([dict[@"errorCode"]intValue] == 0) {
            [self requestData];
        }else{
            [self showHint:dict[@"message"]];
        }
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}


@end
