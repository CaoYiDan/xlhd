//
//  YwyDetailViewController.m
//  YunWeiShang
//
//  Created by 伯爵 on 2020/3/3.
//  Copyright © 2020 GangMeiTanGongXu. All rights reserved.
//

#import "YwyDetailViewController.h"
#import "YwyCell.h"
#import "YwyListModel.h"
#import "AddryViewController.h"
#import "GzfpViewController.h"

@interface YwyDetailViewController ()

@property (nonatomic ,strong)NSArray *dataArray;
@property (weak, nonatomic) IBOutlet UILabel *dgIdLab;
@property (weak, nonatomic) IBOutlet UILabel *addressLab;

@end
static NSString *const cellId = @"cellId";
@implementation YwyDetailViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"运维员";
    [self createTableView];
    self.tableView.top = 60;
    self.tableView.height = self.tableView.height - 60;
    [self setupView];
    [self requestData];
}

- (void)setupView{
    self.dgIdLab.text = [NSString stringWithFormat:@"电柜ID：%@",self.model.device_code];
    self.addressLab.text = [NSString stringWithFormat:@"电柜地址：%@",self.model.address];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YwyCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellId];
}

- (void)requestData{
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setValue:@"1" forKey:@"page"];
    [param setValue:@"3" forKey:@"limit"];
    [param setValue:self.model.device_code forKey:@"device_code"];
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
    cell.djBtn.hidden = YES;
    [cell getDataWithInfo:self.dataArray[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 170;
}

@end
