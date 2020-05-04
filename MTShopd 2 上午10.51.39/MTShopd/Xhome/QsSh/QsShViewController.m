//
//  QsShViewController.m
//  MTShopd
//
//  Created by 伯爵 on 2020/2/17.
//  Copyright © 2020 MTShopd. All rights reserved.
//

#import "QsShViewController.h"
#import "QsshCell.h"
#import "QsshListModel.h"

@interface QsShViewController ()

@property (nonatomic ,strong)NSArray *dataArray;

@end
static NSString *const qsshCell = @"QsshCell";
@implementation QsShViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"骑手审核";
    //[self createTableView];
    [self setupView];
    [self requestData];
}

- (void)setupView{
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([QsshCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:qsshCell];
}

- (void)requestData{
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setValue:@"30" forKey:@"limit"];
    [param setValue:@"1" forKey:@"page"];
     NSMutableDictionary *jsonStr = param;
//    NSString *jsonStr = [[Singleton shardeManger]convertToJsonData:param];
    [[DataRequest Manager]  postBossDemoWithUrl:[NSString stringWithFormat:@"%@audit/users",base_url] param:jsonStr success:^(NSDictionary *dict) {
        NSLog(@"%@",dict);
        if ([dict[@"errorCode"]intValue] == 0) {
            self.dataArray = [NSArray yy_modelArrayWithClass:[QsshListModel class] json:dict[@"data"]];
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
    QsshListModel *model = self.dataArray[indexPath.row];
    QsshCell *cell = [QsshCell loadFromNIB];
    if (!cell) {
        cell = [[QsshCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:qsshCell];
    }
    cell.tongYiBtn.tag = indexPath.row;
    cell.juJueBtn.tag = indexPath.row;
    [cell.tongYiBtn addTarget:self action:@selector(tongYiBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.juJueBtn addTarget:self action:@selector(juJueBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.phoneLab.text = model.phone_number;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (void)tongYiBtnClick:(UIButton *)btn{
    QsshListModel *model = self.dataArray[btn.tag];
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setValue:model.phone_number forKey:@"phone_number"];
     NSMutableDictionary *jsonStr = param;
//    NSString *jsonStr = [[Singleton shardeManger]convertToJsonData:param];
    [[DataRequest Manager]  postBossDemoWithUrl:[NSString stringWithFormat:@"%@audit/adopt",base_url] param:jsonStr success:^(NSDictionary *dict) {
        if ([dict[@"errorCode"]intValue] == 0) {
            [self requestData];
        }else{
            [self showHint:dict[@"message"]];
        }
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)juJueBtnClick:(UIButton *)btn{
    QsshListModel *model = self.dataArray[btn.tag];
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setValue:model.phone_number forKey:@"phone_number"];
     NSMutableDictionary *jsonStr = param;
//    NSString *jsonStr = [[Singleton shardeManger]convertToJsonData:param];
    [[DataRequest Manager]  postBossDemoWithUrl:[NSString stringWithFormat:@"%@audit/reject",base_url] param:jsonStr success:^(NSDictionary *dict) {
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
