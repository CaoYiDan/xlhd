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
#import "UserViewController.h"
#import "HomeViewController.h"

@interface MCTabBarController ()<UITabBarControllerDelegate>

@property (nonatomic, strong) HomeViewController *homeVC;
@property (nonatomic, strong) UserViewController *userVC;
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
    [self addChildrenViewController:[[UserViewController alloc] init] andTitle:@"用户管理" andImageName:@"用户管理" andSelectImage:@"用户管理 拷贝"];
    [self addChildrenViewController:[[HomeViewController alloc] init] andTitle:@"电池管理" andImageName:@"电池" andSelectImage:@"电池 拷贝"];
    
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
