//
//  BaseNavigationController.m
//  MCTabBarDemo
//
//  Created by chh on 2017/12/18.
//  Copyright © 2017年 Mr.C. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.translucent = NO;
    self.navigationBar.tintColor = [UIColor blackColor]; //设置导航栏左侧与右侧按钮颜色
    [self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],NSForegroundColorAttributeName, nil]]; //设置导航栏标题文字属性
    self.navigationBar.barTintColor = RGB(28, 144, 247); //设置导航栏背景色
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -500) forBarMetrics:UIBarMetricsDefault];
    
    UIOffset offset;
    offset.horizontal = -500;
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:offset forBarMetrics:UIBarMetricsDefault];
}

//重写这个方法，在跳转后自动隐藏tabbar
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([self.viewControllers count] > 0){
        viewController.hidesBottomBarWhenPushed = YES;
//        [AppDelegate delegate].isAddBtnShow = NO;
    }
    //一定要写在最后，要不然无效
    [super pushViewController:viewController animated:animated];
    
    
}


@end
