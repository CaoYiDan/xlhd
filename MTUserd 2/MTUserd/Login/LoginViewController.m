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
#import "BindShopViewController.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    [self.codeBtn setBorderLineWithColor:RGB(170, 213, 252)];
}

- (IBAction)getCodeBtnClick:(UIButton *)sender {
    if (self.phoneTF.text.length!=11||[[Singleton shardeManger] checkTelNumber:self.phoneTF.text]==NO) {
        [self showHint:@"请输入正确的手机号"];
        return;
    }
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setValue:self.phoneTF.text forKey:@"phone_number"];
    NSString *jsonStr = [[Singleton shardeManger]convertToJsonData:param];
    [[DataRequest Manager] postBossDemoWithUrl:[NSString stringWithFormat:@"%@login/send-sms",base_url] param:jsonStr success:^(NSDictionary *dict) {

        if ([dict[@"errorCode"]intValue] == 0) {
            [self openCountdown];
            [self showHint:dict[@"message"]];
        }else{
            [self showHint:dict[@"message"]];
        }
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
    
//    // 请求头
//    NSString *accessPath = @"http://mtcc001.zhixingonline.com/app/login/send-sms";
//    // 请求参数字典
//    NSDictionary *params = @{@"phonenumber":self.phoneTF.text};
//
//    NSLog(@"发送请求url=%@,params=%@",accessPath,params);
//
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
//    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:accessPath parameters:params error:nil];
//    request.timeoutInterval = 10.f;
//    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
////    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//    [request setValue:@"ios" forHTTPHeaderField:@"X-Api-Type"];
//    [request setValue:@"user" forHTTPHeaderField:@"X-Api-End"];
//
////    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json",@"text/json", @"text/javascript",@"text/html",@"text/plain", nil]];
//
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"text/html",@"application/json",@"Accept:",@"q=1.0, */*; q=0.1 ", nil];
//
////    [manager.requestSerializer setValue:@"ios" forHTTPHeaderField:@"X-Api-Type"];
////
////    [manager.requestSerializer setValue:@"user" forHTTPHeaderField:@"X-Api-End"];
////
////    [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//
//    NSURLSessionDataTask *task = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
//        NSLog(@"-----responseObject===%@+++++",responseObject);
//        if (!error) {
//            if ([responseObject isKindOfClass:[NSDictionary class]]) {
//                // 请求成功数据处理
//            } else {
//
//            }
//        } else {
//            NSLog(@"请求失败error=%@", error);
//        }
//    }];
//
//    [task resume];
}




- (IBAction)loginBtnClick:(UIButton *)sender {

//    [[NSUserDefaults standardUserDefaults] setObject:@"AlveK9mILPgktGKvVHjt_W1hi1IeEo9k" forKey:@"user_token"];
//    BindShopViewController *bindVC = [[BindShopViewController alloc]init];
//    [self.navigationController pushViewController:bindVC animated:YES];
//    return;

    if (self.phoneTF.text.length!=11||[[Singleton shardeManger] checkTelNumber:self.phoneTF.text]==NO) {
        return [self showHint:@"请输入正确的手机号"];
    }
    if (!self.codeTF.text.length){
        return [self showHint:@"请输入验证码"];
    }
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setValue:self.phoneTF.text forKey:@"phone_number"];
    [param setValue:self.codeTF.text forKey:@"sms_code"];
    NSString *jsonStr = [[Singleton shardeManger]convertToJsonData:param];
    [[DataRequest Manager] postBossDemoWithUrl:[NSString stringWithFormat:@"%@login",base_url] param:jsonStr success:^(NSDictionary *dict) {
        if ([dict[@"errorCode"]intValue] == 0) {
            [[NSUserDefaults standardUserDefaults] setObject:dict[@"data"][@"token"] forKey:@"user_token"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            NSLog(@"%@",dict);
            
            //查询是否绑定
            [[DataRequest Manager] postBossDemoWithUrl:[NSString stringWithFormat:@"%@user/merchant-isbind",base_url] param:nil success:^(NSDictionary *dict) {
                if ([dict[@"errorCode"]intValue] == 0) {
                    
                    if (![dict[@"data"][@"isbind"] boolValue]) {
                        //未绑定，跳转到绑定界面
                        BindShopViewController *bindVC = [[BindShopViewController alloc]init];
                        [self.navigationController pushViewController:bindVC animated:YES];
                    }else{
                        //已绑定，跳转到首页
                        HomeViewController *homeVC = [[HomeViewController alloc]init];
                        BaseNavigationController *nav = [[BaseNavigationController alloc]initWithRootViewController:homeVC];
                        [AppDelegate delegate].window.rootViewController = nav;
                    }
                }else{
                    [self showHint:dict[@"message"]];
                }
            } fail:^(NSError *error) {
                 NSLog(@"%@",error);
            }];
            
            
        }else{
            
            [self showHint:dict[@"message"]];
        }
        
    } fail:^(NSError *error) {
         NSLog(@"%@",error);
    }];
    
}

-(void)openCountdown{
    
    __block NSInteger time = 59; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮的样式
                [self.codeBtn setTitle:@"重新发送" forState:UIControlStateNormal];
                self.codeBtn.userInteractionEnabled = YES;
            });
            
        }else{
            
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮显示读秒效果
                [self.codeBtn setTitle:[NSString stringWithFormat:@"(%.2d)", seconds] forState:UIControlStateNormal];
                //                [self.codeBtn setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
//                [self.codeBtn setBackgroundColor:[UIColor colorWithRed:36/255.0 green:36/255.0 blue:36/255.0 alpha:1]];
                self.codeBtn.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}

@end
