//
//  SetViewController.m
//  MTYunWeiYuan
//
//  Created by 伯爵 on 2020/2/4.
//  Copyright © 2020 MTShopd. All rights reserved.
//

#import "SetViewController.h"
#import "FltkViewController.h"
#import "YjfkViewController.h"
#import "LoginViewController.h"

@interface SetViewController ()

@end

@implementation SetViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(236, 237, 238);
    self.title = @"设置";
    
}

- (IBAction)outLoginBtnClick:(UIButton *)sender {
    switch (sender.tag) {
        case 200:{
            FltkViewController *fltkVC = [[FltkViewController alloc]init];
            fltkVC.titleStr = @"法律条款及协议";
            fltkVC.urlStr = @"https://mtccuser.zhixingonline.com/h5/clause.html";
            [[[Singleton shardeManger]getCurrentVC].navigationController pushViewController:fltkVC animated:YES];
        }
            break;
        case 300:{
            YjfkViewController *yjfkVC = [[YjfkViewController alloc]init];
            [[[Singleton shardeManger]getCurrentVC].navigationController pushViewController:yjfkVC animated:YES];
        }
            break;
        case 400:{
            FltkViewController *fltkVC = [[FltkViewController alloc]init];
            fltkVC.titleStr = @"关于我们";
            fltkVC.urlStr = @"https://mtccuser.zhixingonline.com/h5/about.html";
            [[[Singleton shardeManger]getCurrentVC].navigationController pushViewController:fltkVC animated:YES];
        }
            break;
        case 500:{
            FltkViewController *fltkVC = [[FltkViewController alloc]init];
            fltkVC.titleStr = @"联系我们";
            fltkVC.urlStr = @"https://mtccuser.zhixingonline.com/h5/contact.html";
            [[[Singleton shardeManger]getCurrentVC].navigationController pushViewController:fltkVC animated:YES];
        }
            break;
        case 700:{
           [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"user_token"];
            LoginViewController *login = [[LoginViewController alloc]init];
            BaseNavigationController *logNavi = [[BaseNavigationController alloc]initWithRootViewController:login];
            [AppDelegate delegate].window.rootViewController = logNavi;
        }
            break;
            
        default:
            break;
    }
    
}


@end
