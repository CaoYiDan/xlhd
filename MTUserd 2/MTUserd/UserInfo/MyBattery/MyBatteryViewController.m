//
//  MyBatteryViewController.m
//  MTUserd
//
//  Created by 伯爵 on 2019/11/15.
//  Copyright © 2019 MTShopd. All rights reserved.
//

#import "MyBatteryViewController.h"

@interface MyBatteryViewController ()

@property (weak, nonatomic) IBOutlet UILabel *dlLab;
@property (weak, nonatomic) IBOutlet UILabel *sjLab;
@property (weak, nonatomic) IBOutlet UILabel *dcbmLab;
@property (weak, nonatomic) IBOutlet UILabel *dqdlLab;
@property (weak, nonatomic) IBOutlet UILabel *sydlLab;


@end

@implementation MyBatteryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的电池";
//    [self requestData];
}

- (void)requestData{
//    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
//    [param setValue:self.phoneTF.text forKey:@"phonenumber"];
//    NSString *jsonStr = [[Singleton shardeManger]convertToJsonData:param];
    [[DataRequest Manager] postBossDemoWithUrl:[NSString stringWithFormat:@"%@battery/my-battery",base_url] param:nil success:^(NSDictionary *dict) {
        if ([dict[@"errorCode"]intValue] == 0) {
            self.model = [BatteryModel yy_modelWithJSON:dict[@"data"]];
            [self setupView];
        }else{
            [self showHint:dict[@"message"]];
        }
    } fail:^(NSError *error) {
         NSLog(@"%@",error);
    }];
}

- (void)setupView{
    self.sydlLab.text = [NSString stringWithFormat:@"%@%",self.model.battery_percentage];
    self.dlLab.text = [NSString stringWithFormat:@"%@%",self.model.battery_percentage];
    self.dcbmLab.text = self.model.device_code;
    self.dqdlLab.text = [NSString stringWithFormat:@"%@%",self.model.battery_percentage];
    self.sjLab.text = self.model.merchant_name;
}

@end
