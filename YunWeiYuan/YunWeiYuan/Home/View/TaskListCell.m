//
//  TaskListCell.m
//  YunWeiYuan
//
//  Created by 伯爵 on 2020/2/24.
//  Copyright © 2020 GangMeiTanGongXu. All rights reserved.
//

#import "TaskListCell.h"
#import "GzclViewController.h"
@implementation TaskListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)getDataWithInfo:(TaskListModel *)model{
    self.model = model;
    self.gdNumLab.text = [NSString stringWithFormat:@"工单号：%@",model.repair_id];
    self.sbIdLab.text = [NSString stringWithFormat:@"设备ID：%@",model.device_code];
    self.addressLab.text = [NSString stringWithFormat:@"站点地址：%@",model.address];
    self.msLab.text = [NSString stringWithFormat:@"问题描述：%@",model.describe];
    if (model.repair_status == 0) {
//        self.gzclBtn.enabled = NO;
        [self.gzclBtn setTitle:@"故障处理" forState:UIControlStateNormal];
    }else{
//        self.gzclBtn.enabled = YES;
        [self.gzclBtn setTitle:@"已完成" forState:UIControlStateNormal];
    }

}

- (IBAction)gzclBtnClick:(UIButton *)sender {
    if ([sender.titleLabel.text isEqualToString:@"故障处理"]) {
        GzclViewController *gzclVC = [[GzclViewController alloc]init];
        gzclVC.model = self.model;
        [[[Singleton shardeManger]getCurrentVC].navigationController pushViewController:gzclVC animated:YES];
    }
}

@end
