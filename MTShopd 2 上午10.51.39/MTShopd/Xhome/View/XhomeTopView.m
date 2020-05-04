//
//  XhomeTopView.m
//  MTShopd
//
//  Created by 伯爵 on 2020/2/13.
//  Copyright © 2020 MTShopd. All rights reserved.
//

#import "XhomeTopView.h"
#import "YuETxViewController.h"
#import "UserInfoViewController.h"
@implementation XhomeTopView

- (void)awakeFromNib{
    
    [super awakeFromNib];
    [self.txBtn setBorderLineWithColor:mainColor];
    
    self.txBtn.hidden = YES;
    
    ls_addTapGestureRecognizer(self.ewmImg, {
        UserInfoViewController *userInfoVC = [[UserInfoViewController alloc]init];
        [[[Singleton shardeManger]getCurrentVC].navigationController pushViewController:userInfoVC animated:YES];
    })
}

- (IBAction)txBtnClick:(UIButton *)sender {
    Toast(@"提现功能关闭了？");
    return;
    YuETxViewController *txVC = [[YuETxViewController alloc]init];
    [[[Singleton shardeManger]getCurrentVC].navigationController pushViewController:txVC animated:YES];
}

@end
