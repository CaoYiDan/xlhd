//
//  AppDelegate.m
//  MTShopd
//
//  Created by 伯爵 on 2019/11/7.
//  Copyright © 2019 MTShopd. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

+ (id)delegate{
    return [UIApplication sharedApplication].delegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    
    if (Token) {
        XhomeViewController *homeVC = [[XhomeViewController alloc]init];
        BaseNavigationController *nav = [[BaseNavigationController alloc]initWithRootViewController:homeVC];
        self.window.rootViewController = nav;
    }else{
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        BaseNavigationController *nav = [[BaseNavigationController alloc]initWithRootViewController:loginVC];
        self.window.rootViewController = nav;
        [self.window makeKeyAndVisible];
    }
    
    [WXApi registerApp:@"wxdaf0ce4d3cf99687"];


    return YES;
}


//#pragma mark - UISceneSession lifecycle
//
//
//- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
//    // Called when a new scene session is being created.
//    // Use this method to select a configuration to create the new scene with.
//    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
//}
//
//
//- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
//    // Called when the user discards a scene session.
//    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//}


@end
