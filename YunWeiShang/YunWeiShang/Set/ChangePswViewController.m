//
//  ChangePswViewController.m
//  MTYunWeiShang
//
//  Created by 伯爵 on 2020/2/8.
//  Copyright © 2020 MTShopd. All rights reserved.
//

#import "ChangePswViewController.h"

@interface ChangePswViewController ()

@property (weak, nonatomic) IBOutlet UITextField *xPswTF;
@property (weak, nonatomic) IBOutlet UITextField *qrPswTF;


@end

@implementation ChangePswViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改密码";
}

- (IBAction)changePswBtnClick:(UIButton *)sender {
    if (!self.xPswTF.text.length) {
        [self showHint:@"请输入新密码"];
    }
    if (![self.xPswTF.text isEqualToString:self.qrPswTF.text]) {
        [self showHint:@"俩次密码不一致"];
    }
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setValue:self.xPswTF.text forKey:@"password"];
    NSMutableDictionary *jsonStr = param;
    //NSMutableDictionary *jsonStr = param;
    //NSString *jsonStr = [[Singleton shardeManger]convertToJsonData:param];
    [[DataRequest Manager] postBossDemoWithUrl:[NSString stringWithFormat:@"%@tsm/reset-password",base_url] param:jsonStr success:^(NSDictionary *dict) {
        if ([dict[@"errorCode"]intValue] == 0) {
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [self showHint:dict[@"message"]];
        }
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

@end
