//
//  GzfpViewController.m
//  YunWeiShang
//
//  Created by 伯爵 on 2020/3/3.
//  Copyright © 2020 GangMeiTanGongXu. All rights reserved.
//

#import "GzfpViewController.h"
#import "GzfpCell.h"
#import "FpywyModel.h"

@interface GzfpViewController ()

@property (nonatomic ,strong)NSArray *dataArray;
@property (nonatomic ,strong)FpywyModel *fpmodel;

@end
static NSString *const cellId = @"cellId";
@implementation GzfpViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"分配运维员";
    [self createTableView];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.height = self.tableView.height - 150;
    [self setupView];
    if (self.model.device_code) {
        [self requestData];
    }else{
        [self ywyRequestData];
    }
}

- (void)setupView{
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([GzfpCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellId];

}

- (void)requestData{
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setValue:@"1" forKey:@"page"];
    [param setValue:@"20" forKey:@"limit"];
    [param setValue:self.model.device_code forKey:@"device_code"];
    NSMutableDictionary *jsonStr = param;
    //NSMutableDictionary *jsonStr = param;
    //NSString *jsonStr = [[Singleton shardeManger]convertToJsonData:param];
    [[DataRequest Manager] postBossDemoWithUrl:[NSString stringWithFormat:@"%@tse/assign-list",base_url] param:jsonStr success:^(NSDictionary *dict){
        if ([dict[@"errorCode"]intValue] == 0) {
            self.dataArray = [NSArray yy_modelArrayWithClass:[FpywyModel class] json:dict[@"data"]];
            [self.tableView reloadData];
        }else{
            [self showHint:dict[@"message"]];
        }
    } fail:^(NSError *error) {
         NSLog(@"%@",error);
    }];
}

- (void)ywyRequestData{
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setValue:@"1" forKey:@"page"];
    [param setValue:@"3" forKey:@"limit"];
    NSMutableDictionary *jsonStr = param;
    //NSMutableDictionary *jsonStr = param;
    //NSString *jsonStr = [[Singleton shardeManger]convertToJsonData:param];
    [[DataRequest Manager] postBossDemoWithUrl:[NSString stringWithFormat:@"%@tse/list",base_url] param:jsonStr success:^(NSDictionary *dict){
        if ([dict[@"errorCode"]intValue] == 0) {
            self.dataArray = [NSArray yy_modelArrayWithClass:[FpywyModel class] json:dict[@"data"]];
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
    GzfpCell *cell = [GzfpCell loadFromNIB];
    if (!cell) {
        cell = [[GzfpCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    [cell getDataWithInfo:self.dataArray[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.fpmodel = self.dataArray[indexPath.row];
    for (FpywyModel *modell in self.dataArray) {
        if (modell == self.fpmodel) {
            modell.selected = YES;
        }else{
            modell.selected = NO;
        }
    }
    [self.tableView reloadData];

}


- (IBAction)fenPeiBtnClick:(UIButton *)sender {
    if (self.model.device_code) {
        NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
        [param setValue:self.fpmodel.phone_number forKey:@"phone_number"];
        [param setValue:self.model.device_code forKey:@"device_code"];
        NSMutableDictionary *jsonStr = param;
    //NSMutableDictionary *jsonStr = param;
    //NSString *jsonStr = [[Singleton shardeManger]convertToJsonData:param];
        [[DataRequest Manager] postBossDemoWithUrl:[NSString stringWithFormat:@"%@tse/cabinet-assign",base_url] param:jsonStr success:^(NSDictionary *dict){
            if ([dict[@"errorCode"]intValue] == 0) {
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [self showHint:dict[@"message"]];
            }
        } fail:^(NSError *error) {
             NSLog(@"%@",error);
        }];
    }else{
        NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
        [param setValue:self.fpmodel.phone_number forKey:@"phone_number"];
        [param setValue:self.gzmodel.warning_id forKey:@"warning_id"];
        NSMutableDictionary *jsonStr = param;
    //NSMutableDictionary *jsonStr = param;
    //NSString *jsonStr = [[Singleton shardeManger]convertToJsonData:param];
        [[DataRequest Manager] postBossDemoWithUrl:[NSString stringWithFormat:@"%@warning/assign",base_url] param:jsonStr success:^(NSDictionary *dict){
            if ([dict[@"errorCode"]intValue] == 0) {
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [self showHint:dict[@"message"]];
            }
        } fail:^(NSError *error) {
             NSLog(@"%@",error);
        }];
    }
    
}

@end
