//
//  OrderManagerViewController.m
//  MTShopd
//
//  Created by 伯爵 on 2020/4/16.
//  Copyright © 2020 MTShopd. All rights reserved.
//

#import "OrderManagerViewController.h"
#import "OrderManegerCell.h"
#import "OrderManagerModel.h"

@interface OrderManagerViewController ()

@property (weak, nonatomic) IBOutlet UILabel *totalNumLab;
@property (weak, nonatomic) IBOutlet UILabel *fjxLab;
@property (weak, nonatomic) IBOutlet UILabel *sjxLab;
@property (weak, nonatomic) IBOutlet UILabel *fwcLab;
@property (weak, nonatomic) IBOutlet UILabel *swcLab;

@property (nonatomic ,strong)NSArray *dataArray;
@property (nonatomic, assign)NSInteger index;

@end
static NSString *const cellId = @"cellID";
@implementation OrderManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(236, 237, 238);
    self.title = @"订单管理";
    self.index = 100;
    //[self createTableView];
    self.tableView.top = 150;
    self.tableView.height = self.tableView.height - 150;
    [self setupView];
    [self requestData];
    [self requestNumData];
}

- (void)setupView{
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([OrderManegerCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellId];
}
- (void)requestNumData{
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
//    [param setValue:@"10" forKey:@"limit"];
//    [param setValue:@"1" forKey:@"page"];
     NSMutableDictionary *jsonStr = param;
//    NSString *jsonStr = [[Singleton shardeManger]convertToJsonData:param];
    [[DataRequest Manager]  postBossDemoWithUrl:[NSString stringWithFormat:@"%@order/number",base_url] param:jsonStr success:^(NSDictionary *dict) {
        if ([dict[@"errorCode"]intValue] == 0) {
            self.fjxLab.text = [NSString stringWithFormat:@"%@",dict[@"data"][@"not_final_number"]];
            self.fwcLab.text = [NSString stringWithFormat:@"%@",dict[@"data"][@"final_number"]];
            self.totalNumLab.text = [NSString stringWithFormat:@"%@",dict[@"data"][@"total_number"]];

        }else{
            [self showHint:dict[@"message"]];
        }
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)requestData{
//    self.dataArray
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    if (self.index == 100) {
        [param setValue:@0 forKey:@"order_status"];
    }else if (self.index == 200){
        [param setValue:@1 forKey:@"order_status"];
    }
    [param setValue:@"10" forKey:@"limit"];
    [param setValue:@"1" forKey:@"page"];
     NSMutableDictionary *jsonStr = param;
//    NSString *jsonStr = [[Singleton shardeManger]convertToJsonData:param];
    [[DataRequest Manager]  postBossDemoWithUrl:[NSString stringWithFormat:@"%@order/pick",base_url] param:jsonStr success:^(NSDictionary *dict) {
        if ([dict[@"errorCode"]intValue] == 0) {
            self.dataArray = [NSArray yy_modelArrayWithClass:[OrderManagerModel class] json:dict[@"data"]];
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
    OrderManegerCell *cell = [OrderManegerCell loadFromNIB];
    if (!cell) {
        cell = [[OrderManegerCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    [cell getDataWithInfo:self.dataArray[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 145;
}

- (IBAction)chooseBtnClick:(UIButton *)sender {
    self.index = sender.tag;
    if (sender.tag == 100) {
        self.fjxLab.textColor = mainColor;
        self.sjxLab.textColor = mainColor;
        self.fwcLab.textColor = RGB(114, 115, 116);
        self.swcLab.textColor = RGB(114, 115, 116);
    }else{
        self.fwcLab.textColor = mainColor;
        self.swcLab.textColor = mainColor;
        self.fjxLab.textColor = RGB(114, 115, 116);
        self.sjxLab.textColor = RGB(114, 115, 116);
    }
    [self requestData];
}


@end
