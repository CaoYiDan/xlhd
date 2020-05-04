//
//  YuEInfoViewController.m
//  MTShopd
//
//  Created by 伯爵 on 2019/11/8.
//  Copyright © 2019 MTShopd. All rights reserved.
//

#import "YuEInfoViewController.h"
#import "YuEView.h"
#import "YuEInfoCell.h"
#import "YeInfoModel.h"

@interface YuEInfoViewController ()

@property (nonatomic ,strong)NSArray *dataArray;

@end
static NSString *const cellId = @"cellId";
@implementation YuEInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"明细";
    //[self createTableView];
    [self setupView];
    [self requestData];
}

- (void)setupView{
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"消息"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBtn)];
        self.navigationItem.rightBarButtonItem = rightBarItem;
    YuEView *topView = [YuEView loadFromNIB];
    self.tableView.tableHeaderView = topView;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YeInfoModel class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellId];

}

- (void)requestData{
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setValue:@"10" forKey:@"limit"];
    [param setValue:@"1" forKey:@"page"];
     NSMutableDictionary *jsonStr = param;
//    NSString *jsonStr = [[Singleton shardeManger]convertToJsonData:param];
    [[DataRequest Manager]  postBossDemoWithUrl:[NSString stringWithFormat:@"%@bill/details",base_url] param:jsonStr success:^(NSDictionary *dict) {
        if ([dict[@"errorCode"]intValue] == 0) {
            self.dataArray = [NSArray yy_modelArrayWithClass:[YeInfoModel class] json:dict[@"data"]];
            [self.tableView reloadData];
        }else{
            [self showHint:dict[@"message"]];
        }
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)rightBtn{
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YuEInfoCell *cell = [YuEInfoCell loadFromNIB];
    if (!cell) {
        cell = [[YuEInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    [cell getDataWithInfo:self.dataArray[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

@end
