//
//  MCTabBarController.m
//  MCTabBarDemo
//
//  Created by chh on 2017/12/4.
//  Copyright © 2017年 Mr.C. All rights reserved.
//

#import "MCTabBarController.h"
#import "ViewController.h"
#import "BaseNavigationController.h"
#import "HomeViewController.h"
#import "CdzXjViewController.h"
#import "YwyListViewController.h"

@interface MCTabBarController ()<UITabBarControllerDelegate>

@property (nonatomic, strong) HomeViewController *homeVC;
@property (nonatomic, strong) CdzXjViewController *cdzxjVC;
@property (nonatomic, strong) YwyListViewController *ywyListVC;
@property (nonatomic, strong) UITabBarItem *lastItem;
@end

@implementation MCTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChildViewControllers];
    [self setDelegate:self];
}
//添加子控制器
- (void)addChildViewControllers{
    //图片大小建议32*32
    [self addChildrenViewController:[[HomeViewController alloc] init] andTitle:@"设备" andImageName:@"未标题-1" andSelectImage:@"选中"];
    [self addChildrenViewController:[[CdzXjViewController alloc] init] andTitle:@"充电站巡检" andImageName:@"未选中02" andSelectImage:@"选中02"];
    [self addChildrenViewController:[[YwyListViewController alloc] init] andTitle:@"运维员" andImageName:@"未选中03" andSelectImage:@"选中03"];
}

- (void)addChildrenViewController:(UIViewController *)childVC andTitle:(NSString *)title andImageName:(NSString *)imageName andSelectImage:(NSString *)selectedImage{
    childVC.tabBarItem.image = [UIImage imageNamed:imageName];
    childVC.tabBarItem.selectedImage =  [UIImage imageNamed:selectedImage];
    childVC.title = title;
    [childVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: mainColor} forState:UIControlStateSelected];
    childVC.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    BaseNavigationController *baseNav = [[BaseNavigationController alloc] initWithRootViewController:childVC];
    [self addChildViewController:baseNav];
}
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
//    if(viewController == [tabBarController.viewControllers objectAtIndex:1])
//    {
//        if ([[[Singleton shardeManger]getCurrentVC] isKindOfClass:[HomeViewController class]]) {
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"homePushService" object:nil];
//        }else{
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"myPushService" object:nil];
//        }
//        return NO;
//    }
    
    return YES;
    
}
//tabbar选择时的代理
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
//    if (tabBarController.selectedIndex == 2){//选中中间的按钮
//        if (![Singleton shardeManger].isLogin) {
//            return [[Singleton shardeManger] gotoLogin];
//        }
//    }else {
//
//    }
}

@end
