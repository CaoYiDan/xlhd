//
//  DgManegerListCell.m
//  MTShopd
//
//  Created by 伯爵 on 2020/3/18.
//  Copyright © 2020 MTShopd. All rights reserved.
//

#import "DgManegerListCell.h"

@implementation DgManegerListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)getDataWithInfo:(DgManagerModel *)model{
    self.model = model;
    self.nameLab.text = model.name;
    self.addressLab.text = model.address;
    self.bhLab.text = [NSString stringWithFormat:@"编号：%@",model.device_code];
    self.dbdsLab.text = [NSString stringWithFormat:@"电表度数：%@",model.power];
    self.dgwdLab.text = [NSString stringWithFormat:@"电柜温度：%@℃",model.humidity];
    self.dgsdLab.text = [NSString stringWithFormat:@"电柜湿度：%@",model.temperature];
    self.phoneLab.text = model.tel;
    if (model.status == 0 || model.status == 4) {
        self.zxLab.text = @"[离线]";
        self.zxLab.textColor = RGB(114, 115, 116);
    }else{
        self.zxLab.text = @"[在线]";
        self.zxLab.textColor = RGB(24, 141, 250);
    }
}

- (IBAction)phoneBtnClick:(UIButton *)sender {
    NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"tel:%@",self.model.tel];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [[[Singleton shardeManger]getCurrentVC].view addSubview:callWebview];
}


@end
