//
//  YyhdCell.m
//  MTUserd
//
//  Created by 伯爵 on 2019/11/16.
//  Copyright © 2019 MTShopd. All rights reserved.
//

#import "YyhdCell.h"

@implementation YyhdCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)getDataWithInfo:(HomeDianGuiModel *)model{
//    NSLog(@"====:%@",model.book.)
    self.model = model;
    self.titleLab.text = model.name;
    self.addressLab.text = [NSString stringWithFormat:@" %@ ",model.address];
    self.countLab.text = [NSString stringWithFormat:@" 可用电池：%@ ",model.batteries];
    if (model.book) {
        self.yuyueView.hidden = NO;
        self.yuyueBtn.hidden = YES;
        double expires_at = [model.book[@"expires_at"] doubleValue];
        self.timeLab.text = [[Singleton shardeManger] getUTCFormateDate:[[Singleton shardeManger]getTimeFromTimestamp:expires_at]];

    }else{
        
        self.yuyueView.hidden = YES;
        self.yuyueBtn.hidden = NO;
        
    }
}

- (IBAction)yuYueBtnClick:(UIButton *)sender {
    
//    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请选择预约时间" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//       //添加输入框
//    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
//    UITextField *txtName = [alert textFieldAtIndex:0];
//    txtName.placeholder = @"请输入时长";
//    [alert show];
    
    BankPickerTool *bankPick = [[BankPickerTool alloc] initWithFrame:CGRectMake(0, ScreenHeight-300, ScreenWidth, 300)];
    [bankPick reloadArray:[[NSMutableArray alloc] initWithObjects:@"",  nil]];
    __block BankPickerTool *blockPicker = bankPick;
    bankPick.callBlock = ^(NSString *pickDate) {
        
        NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
        [param setValue:self.model.device_code forKey:@"device_code"];
        [param setValue:@([pickDate integerValue]*60) forKey:@"planning_time"];
        NSString *jsonStr = [[Singleton shardeManger]convertToJsonData:param];
        NSLog(@"%@",Token);
        [[DataRequest Manager] postBossDemoWithUrl:[NSString stringWithFormat:@"%@battery/book",base_url] param:jsonStr success:^(NSDictionary *dict) {                
            if ([dict[@"errorCode"]intValue] == 0) {
               [[[Singleton shardeManger]getCurrentVC] showHint:dict[@"message"]];
            }else{
                
                [[[Singleton shardeManger]getCurrentVC] showHint:dict[@"message"]];
            }
        } fail:^(NSError *error) {
        }];
        
        [blockPicker removeFromSuperview];
    };
    [[[Singleton shardeManger]getCurrentVC].view addSubview:blockPicker];

    
}

//-(void)alertView:(UIAlertView *)alertView clickeonAtIndex:(NSInteger)buttonIndex{
//    //这里的下标已经是+1了，因为多了一个textField
//    if (buttonIndex == 1) {
//        UITextField *txt = [alertView textFieldAtIndex:0];
//        //获取txt内容即可
//        NSLog(@"%@",txt.text);
//    }
//
//}

- (IBAction)daoHangBtnClick:(UIButton *)sender {
    
    if (self.infoModel) {
        
        CLLocationCoordinate2D myLocation = CLLocationCoordinate2DMake([user_latitude doubleValue],[user_longitude doubleValue]);
        CLLocationCoordinate2D storeLoacation = CLLocationCoordinate2DMake([self.infoModel.lat doubleValue],[self.infoModel.lng doubleValue]);
        myLocation = AMapCoordinateConvert(myLocation,AMapCoordinateTypeGPS);;
        storeLoacation =AMapCoordinateConvert(storeLoacation,AMapCoordinateTypeGPS);;
            
        NSString *urlString = [[NSString stringWithFormat:@"iosamap://path?sourceApplication=%@&sid=BGVIS1&slat=%f&slon=%f&sname=%@&did=BGVIS2&dlat=%f&dlon=%f&dname=%@&dev=0&m=0&t=0",@"", myLocation.latitude, myLocation.longitude,@"我的位置", storeLoacation.latitude, storeLoacation.longitude, self.infoModel.nickname] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:urlString]];

    }else{
        
            CLLocationCoordinate2D myLocation = CLLocationCoordinate2DMake([user_latitude doubleValue],[user_longitude doubleValue]);
            CLLocationCoordinate2D storeLoacation = CLLocationCoordinate2DMake([self.model.lat doubleValue],[self.model.lng doubleValue]);
            myLocation = AMapCoordinateConvert(myLocation,AMapCoordinateTypeGPS);;
            storeLoacation =AMapCoordinateConvert(storeLoacation,AMapCoordinateTypeGPS);;
            
            NSString *urlString = [[NSString stringWithFormat:@"iosamap://path?sourceApplication=%@&sid=BGVIS1&slat=%f&slon=%f&sname=%@&did=BGVIS2&dlat=%f&dlon=%f&dname=%@&dev=0&m=0&t=0",@"", myLocation.latitude, myLocation.longitude,@"我的位置", storeLoacation.latitude, storeLoacation.longitude, self.model.name] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
       
        BOOL canOpen = [[UIApplication sharedApplication]openURL:[NSURL URLWithString:urlString]];
        if (!canOpen) {
            Toast(@"请先安装高德地图app，才能使用此功能");
        }

    }
    
}

- (void)getWxzDataWithInfo:(HomeDianGuiModel *)model{
    self.model = model;
    self.titleLab.text = model.name;
    self.addressLab.text = [NSString stringWithFormat:@" %@ ",model.address];
    self.countLab.text = @"";
    self.juLiLeft.constant = 0;
    self.yuyueBtn.hidden = YES;
    self.yuyueView.hidden = YES;
}

- (void)getGhdcDataWithInfo:(GhdcInfoModel *)model{
    self.infoModel = model;
    self.titleLab.text = model.nickname;
    self.addressLab.text = [NSString stringWithFormat:@" %@ ",model.address];
    self.countLab.text = @"";
    self.juLiLeft.constant = 0;
    self.yuyueBtn.hidden = YES;
    self.yuyueView.hidden = YES;
}

@end
