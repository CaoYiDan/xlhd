//
//  YwyListViewController.m
//  YunWeiShang
//
//  Created by 伯爵 on 2020/2/29.
//  Copyright © 2020 GangMeiTanGongXu. All rights reserved.
//

#import "YwyListViewController.h"
#import "YwyCell.h"
#import "YwyListModel.h"
#import "AddryViewController.h"
#import "GzfpViewController.h"

@interface YwyListViewController ()

@property (nonatomic ,strong)NSArray *dataArray;

@end
static NSString *const cellId = @"cellId";
@implementation YwyListViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTableView];
    self.tableView.top = 60;
    self.tableView.height = self.tableView.height - 60;
    [self setupView];
}

- (void)setupView{
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YwyCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellId];

}

- (void)requestData{
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setValue:@"1" forKey:@"page"];
    [param setValue:@"30" forKey:@"limit"];
    NSMutableDictionary *jsonStr = param;
    //NSMutableDictionary *jsonStr = param;
    //NSString *jsonStr = [[Singleton shardeManger]convertToJsonData:param];
    [[DataRequest Manager] postBossDemoWithUrl:[NSString stringWithFormat:@"%@tse/list",base_url] param:jsonStr success:^(NSDictionary *dict){
        if ([dict[@"errorCode"]intValue] == 0) {
            self.dataArray = [NSArray yy_modelArrayWithClass:[YwyListModel class] json:dict[@"data"]];
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
    YwyCell *cell = [YwyCell loadFromNIB];
    if (!cell) {
        cell = [[YwyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    [cell getDataWithInfo:self.dataArray[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 170;
}

- (IBAction)ywyBtnClick:(UIButton *)sender {
    if (sender.tag == 100) {
        GzfpViewController *gzfpVC = [[GzfpViewController alloc]init];
        [self.navigationController pushViewController:gzfpVC animated:YES];
    }else{
        AddryViewController *addryVC = [[AddryViewController alloc]init];
        [self.navigationController pushViewController:addryVC animated:YES];
    }
}


@end
