//
//  YuEView.m
//  MTShopd
//
//  Created by 伯爵 on 2019/11/8.
//  Copyright © 2019 MTShopd. All rights reserved.
//

#import "YuEView.h"
#import "YuETxViewController.h"

@implementation YuEView

- (void)awakeFromNib{
    [super awakeFromNib];
    [self.txBtn setBorderLineWithColor:mainColor];
}

- (IBAction)chooseBtnClick:(UIButton *)sender {
    for (UIButton *btn in self.buttons) {
        if (sender == btn) {
            btn.titleLabel.font = [UIFont systemFontOfSize:18.0];
            [btn setTitleColor:mainColor forState:UIControlStateNormal];
        }else{
            btn.titleLabel.font = [UIFont systemFontOfSize:15.0];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
    }
}
- (IBAction)tiXianBtnClick:(id)sender {
    YuETxViewController *yetxVC = [[YuETxViewController alloc]init];
    [[[Singleton shardeManger]getCurrentVC].navigationController pushViewController:yetxVC animated:YES];
}

@end
