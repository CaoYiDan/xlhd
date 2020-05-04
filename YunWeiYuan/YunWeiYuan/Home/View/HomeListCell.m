//
//  HomeListCell.m
//  YunWeiYuan
//
//  Created by 伯爵 on 2020/2/24.
//  Copyright © 2020 GangMeiTanGongXu. All rights reserved.
//

#import "HomeListCell.h"
#import "MzxjViewController.h"
#import "GzclViewController.h"
#import "HomeDetailViewController.h"

@implementation HomeListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)homeCellBtnClick:(UIButton *)sender {
    if (sender.tag == 100) {
        MzxjViewController *mzxjVC = [[MzxjViewController alloc]init];
        mzxjVC.model = self.model;
        mzxjVC.titleStr = @"每周巡检";
        [[[Singleton shardeManger]getCurrentVC].navigationController pushViewController:mzxjVC animated:YES];
    }else if (sender.tag == 200){
//        GzclViewController *gzclVC = [[GzclViewController alloc]init];
//        gzclVC.homeModel = self.model;
//        [[[Singleton shardeManger]getCurrentVC].navigationController pushViewController:gzclVC animated:YES];
        MzxjViewController *mzxjVC = [[MzxjViewController alloc]init];
        mzxjVC.titleStr = @"提交故障";
        mzxjVC.model = self.model;
        [[[Singleton shardeManger]getCurrentVC].navigationController pushViewController:mzxjVC animated:YES];
    }else{
        HomeDetailViewController *homeDetailVC = [[HomeDetailViewController alloc]init];
        homeDetailVC.model = self.model;
        [[[Singleton shardeManger]getCurrentVC].navigationController pushViewController:homeDetailVC animated:YES];
    }
}

- (void)getDataWithInfo:(HomeListModel *)model{
    self.model = model;
    self.nameLab.text = [NSString stringWithFormat:@"名称：%@",model.cabinet_name];
    self.bhLab.text = [NSString stringWithFormat:@"编号：%@",model.device_code];
    self.addressLab.text = [NSString stringWithFormat:@"地址：%@",model.address];
    if ([model.cabinet_status isEqualToString:@"0"]) {
        self.stateBtn.backgroundColor = RGB(139, 48, 35);
        [self.stateBtn setTitle:@"离线" forState:UIControlStateNormal];
    }else{
        self.stateBtn.backgroundColor = mainColor;
        [self.stateBtn setTitle:@"在线" forState:UIControlStateNormal];
    }
}

@end
