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
#import "GzfpViewController.h"
#import "YwyDetailViewController.h"
#import "CdzXjViewController.h"
#import "GzListViewController.h"

@implementation HomeListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)homeCellBtnClick:(UIButton *)sender {
    if (sender.tag == 100) {
        CdzXjViewController *cdzxjVC = [[CdzXjViewController alloc]init];
        cdzxjVC.model = self.model;
        cdzxjVC.titleStr = @"home";
        [[[Singleton shardeManger]getCurrentVC].navigationController pushViewController:cdzxjVC animated:YES];
    }else if (sender.tag == 200){
        GzListViewController *gzclVC = [[GzListViewController alloc]init];
        gzclVC.model = self.model;
        [[[Singleton shardeManger]getCurrentVC].navigationController pushViewController:gzclVC animated:YES];
    }else if (sender.tag == 300){
        YwyDetailViewController *ywyDetailVC = [[YwyDetailViewController alloc]init];
        ywyDetailVC.model = self.model;
        [[[Singleton shardeManger]getCurrentVC].navigationController pushViewController:ywyDetailVC animated:YES];
    }else if (sender.tag == 400){
        GzfpViewController *gzfpVC = [[GzfpViewController alloc]init];
        gzfpVC.model = self.model;
        [[[Singleton shardeManger]getCurrentVC].navigationController pushViewController:gzfpVC animated:YES];
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
