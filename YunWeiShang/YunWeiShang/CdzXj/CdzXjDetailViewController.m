//
//  CdzXjDetailViewController.m
//  YunWeiShang
//
//  Created by 伯爵 on 2020/3/11.
//  Copyright © 2020 GangMeiTanGongXu. All rights reserved.
//

#import "CdzXjDetailViewController.h"
#import "CdzxjDetailModel.h"

@interface CdzXjDetailViewController ()

@property (nonatomic ,strong)CdzxjDetailModel *detailModel;

@property (weak, nonatomic) IBOutlet UILabel *sbIdLab;
@property (weak, nonatomic) IBOutlet UILabel *cdgLab;
@property (weak, nonatomic) IBOutlet UILabel *addressLab;
@property (weak, nonatomic) IBOutlet UILabel *stateLab;
@property (weak, nonatomic) IBOutlet UILabel *msLab;


@end

@implementation CdzXjDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(236, 237, 238);
    self.title = @"充电站巡检详情";
    [self requestData];
}

- (void)requestData{
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setValue:self.model.check_id forKey:@"check_id"];
    NSMutableDictionary *jsonStr = param;
    //NSMutableDictionary *jsonStr = param;
    //NSString *jsonStr = [[Singleton shardeManger]convertToJsonData:param];
    [[DataRequest Manager] postBossDemoWithUrl:[NSString stringWithFormat:@"%@check/item",base_url] param:jsonStr success:^(NSDictionary *dict) {
        if ([dict[@"errorCode"]intValue] == 0) {
            self.detailModel = [CdzxjDetailModel yy_modelWithJSON:dict[@"data"]];
            self.sbIdLab.text = [NSString stringWithFormat:@"设备ID：%@",self.detailModel.check_id];
            self.cdgLab.text = [NSString stringWithFormat:@"充电柜：%@",self.detailModel.cabinet_name];
            self.addressLab.text = [NSString stringWithFormat:@"站点地址：：%@",self.detailModel.cabinet_address];
            if ([self.detailModel.status isEqualToString:@"0"]) {
                self.sbIdLab.text = [NSString stringWithFormat:@"状态：故障"];
            }else{
                self.sbIdLab.text = [NSString stringWithFormat:@"状态：正常"];
            }
            self.msLab.text = [NSString stringWithFormat:@"描述：%@",self.detailModel.describe];

        }else{
            [self showHint:dict[@"message"]];
        }
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

@end
