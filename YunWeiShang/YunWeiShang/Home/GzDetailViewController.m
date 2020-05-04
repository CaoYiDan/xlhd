//
//  GzDetailViewController.m
//  YunWeiShang
//
//  Created by 伯爵 on 2020/3/3.
//  Copyright © 2020 GangMeiTanGongXu. All rights reserved.
//

#import "GzDetailViewController.h"
#import "GzDetailCell.h"
#import "GzDetailModel.h"

@interface GzDetailViewController ()

@property (nonatomic ,strong)NSArray *dataArray;
@property (weak, nonatomic) IBOutlet UILabel *dgbhLab;
@property (weak, nonatomic) IBOutlet UILabel *addressLab;
@property (weak, nonatomic) IBOutlet UILabel *gzLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;

@end
static NSString *const cellId = @"cellId";
@implementation GzDetailViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(236, 237, 238);
    self.title = @"故障详情";
//    [self createTableView];
    [self setupView];
    [self requestData];
}

- (void)setupView{
//    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([GzDetailCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellId];
}

- (void)requestData{
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setValue:self.model.warning_id forKey:@"warning_id"];
    NSMutableDictionary *jsonStr = param;
    //NSMutableDictionary *jsonStr = param;
    //NSString *jsonStr = [[Singleton shardeManger]convertToJsonData:param];
    [[DataRequest Manager] postBossDemoWithUrl:[NSString stringWithFormat:@"%@warning/item",base_url] param:jsonStr success:^(NSDictionary *dict) {
        if ([dict[@"errorCode"]intValue] == 0) {
            GzDetailModel *model = [GzDetailModel yy_modelWithJSON:dict[@"data"]];
            self.dgbhLab.text = [NSString stringWithFormat:@"电柜编号：%@",model.device_code];
            self.addressLab.text = [NSString stringWithFormat:@"电柜地址：%@",model.cabinet_address];
            self.gzLab.text = [NSString stringWithFormat:@"故 障：故障"];
            self.timeLab.text = [NSString stringWithFormat:@"报警时间：%@",model.create_time];
        }else{
            [self showHint:dict[@"message"]];
        }
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return self.dataArray.count;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    GzDetailCell *cell = [GzDetailCell loadFromNIB];
//    if (!cell) {
//        cell = [[GzDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
//    }
//    [cell getDataWithInfo:self.dataArray[indexPath.row]];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    return cell;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 200;
//}

@end
