//
//  ChangePswViewController.m
//  MTYunWeiShang
//
//  Created by 伯爵 on 2020/2/8.
//  Copyright © 2020 MTShopd. All rights reserved.
//

#import "ChangePswViewController.h"

@interface ChangePswViewController ()

@property (weak, nonatomic) IBOutlet UITextField *xpswTF;
@property (weak, nonatomic) IBOutlet UITextField *qrPswTF;

@end

@implementation ChangePswViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"修改密码";
}

- (IBAction)ensureBtnClick:(UIButton *)sender {
    if (!self.xpswTF.text.length) {
        return [self showHint:@"请填写新密码"];
    }
    if (![self.xpswTF.text isEqualToString:self.qrPswTF.text]) {
        return [self showHint:@"俩次密码不一致"];
    }
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setValue:self.qrPswTF.text forKey:@"password"];
    NSMutableDictionary *jsonStr = param;
//     NSMutableDictionary *jsonStr = param;
//    NSString *jsonStr = [[Singleton shardeManger]convertToJsonData:param];
    [[DataRequest Manager] postBossDemoWithUrl:[NSString stringWithFormat:@"%@tse/reset-password",base_url] param:jsonStr success:^(NSDictionary *dict) {
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
