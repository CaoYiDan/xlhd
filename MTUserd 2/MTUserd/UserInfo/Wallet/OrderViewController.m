//
//  OrderViewController.m
//  MTUserd
//
//  Created by 伯爵 on 2019/11/15.
//  Copyright © 2019 MTShopd. All rights reserved.
//

#import "OrderViewController.h"
#import "OrderCell.h"
#import "OrderModel.h"

@interface OrderViewController ()

@property (nonatomic ,strong)NSArray *dataArray;

@end
static NSString *const cellId = @"cellId";
@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的订单";
    [self createTableView];
    [self setupView];
    [self requestData];
}

- (void)setupView{
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([OrderCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellId];

}

- (void)requestData{
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    NSString *jsonStr = [[Singleton shardeManger]convertToJsonData:param];
    [[DataRequest Manager] postBossDemoWithUrl:[NSString stringWithFormat:@"%@order/pick",base_url] param:jsonStr success:^(NSDictionary *dict) {
        if ([dict[@"errorCode"]intValue] == 0) {
            self.dataArray = [NSArray yy_modelArrayWithClass:[OrderModel class] json:dict[@"data"]];
            [self.tableView reloadData];
        }else{
            [self showHint:dict[@"message"]];
        }
    } fail:^(NSError *error) {
//         NSLog(@"%@",error);
    }];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderCell *cell = [OrderCell loadFromNIB];
    if (!cell) {
        cell = [[OrderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    [cell getDataWithInfo:self.dataArray[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 186;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


@end
