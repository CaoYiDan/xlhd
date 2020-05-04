//
//  GzListCell.m
//  YunWeiShang
//
//  Created by 伯爵 on 2020/3/2.
//  Copyright © 2020 GangMeiTanGongXu. All rights reserved.
//

#import "GzListCell.h"
#import "GzfpViewController.h"
@implementation GzListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)getDataWithInfo:(GzListModel *)model{
    self.model = model;
    self.sbIdLab.text = [NSString stringWithFormat:@"设备ID：%@",model.warning_id];
    self.addressLab.text = [NSString stringWithFormat:@"站点地址：%@",model.cabinet_address];
    if (model.finished == 1) {
//        self.gzclBtn.userInteractionEnabled = NO;
        [self.gzclBtn setTitle:@"已完成" forState:UIControlStateNormal];
    }else{
        if (model.allow_assign == 0) {
//            self.gzclBtn.userInteractionEnabled = NO;
            [self.gzclBtn setTitle:@"处理中" forState:UIControlStateNormal];
        }else{
//            self.gzclBtn.userInteractionEnabled = YES;
            [self.gzclBtn setTitle:@"故障处理" forState:UIControlStateNormal];
        }
    }
}

- (IBAction)gzclBtnClick:(UIButton *)sender {
    if ([sender.titleLabel.text isEqualToString:@"故障处理"]) {
        GzfpViewController *gzfpVC = [[GzfpViewController alloc]init];
           gzfpVC.gzmodel = self.model;
        [[[Singleton shardeManger]getCurrentVC].navigationController pushViewController:gzfpVC animated:YES];
    }
}


@end
