//
//  LoginViewController.m
//  MTUserd
//
//  Created by 伯爵 on 2019/11/11.
//  Copyright © 2019 MTShopd. All rights reserved.
//

#import "LoginViewController.h"
#import "AFHTTPSessionManager.h"
#import <AVFoundation/AVFoundation.h>
@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *pswTF;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
}


- (IBAction)loginBtnClick:(UIButton *)sender {
    if (!self.phoneTF.text.length) {
        return [self showHint:@"请输入正确的账号"];
    }
    if (!self.pswTF.text.length){
        return [self showHint:@"请输入密码"];
    }
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setValue:self.phoneTF.text forKey:@"account"];
    [param setValue:self.pswTF.text forKey:@"password"];

    NSMutableDictionary *jsonStr = param;
    //NSMutableDictionary *jsonStr = param;
    //NSString *jsonStr = [[Singleton shardeManger]convertToJsonData:param];
    [[DataRequest Manager] postBossDemoWithUrl:[NSString stringWithFormat:@"%@login",base_url] param:jsonStr success:^(NSDictionary *dict) {
        NSLog(@"11111:%@",dict);
        if ([dict[@"errorCode"]intValue] == 0) {
            [[NSUserDefaults standardUserDefaults] setObject:dict[@"data"][@"token"] forKey:@"user_token"];
            [AppDelegate delegate].window.rootViewController = [[MCTabBarController alloc] init];
        }else{
            [self showHint:dict[@"message"]];
        }
    } fail:^(NSError *error) {
         NSLog(@"%@",error);
    }];
    
}




@end
