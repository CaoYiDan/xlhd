//
//  AppDelegate.m
//  YunWeiYuan
//
//  Created by 伯爵 on 2020/2/21.
//  Copyright © 2020 GangMeiTanGongXu. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()<CLLocationManagerDelegate>

@property (nonatomic,strong ) CLLocationManager *locationManager;

@end

@implementation AppDelegate

+ (id)delegate{
    return [UIApplication sharedApplication].delegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    if (Token) {
        HomeViewController *homeVC = [[HomeViewController alloc]init];
        BaseNavigationController *nav = [[BaseNavigationController alloc]initWithRootViewController:homeVC];
        self.window.rootViewController = nav;
    }else{
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        BaseNavigationController *nav = [[BaseNavigationController alloc]initWithRootViewController:loginVC];
        self.window.rootViewController = nav;
        [self.window makeKeyAndVisible];
    }
    [AMapServices sharedServices].apiKey = @"d7ca8f712ebc56d9256395130a048908";
    [self locatemap];

    return YES;
}

- (void)locatemap{
    
    if ([CLLocationManager locationServicesEnabled]) {
        _locationManager = [[CLLocationManager alloc]init];
        _locationManager.delegate = self;
        [_locationManager requestAlwaysAuthorization];
        [_locationManager requestWhenInUseAuthorization];
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = 5.0;
//        _locationManager.locationTimeout =10;
//        _locationManager.reGeocodeTimeout = 10;
        [_locationManager startUpdatingLocation];
    }
}
#pragma mark - 定位成功
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{

    [_locationManager stopUpdatingLocation];
    CLLocation *currentLocation = [locations lastObject];
    //当前的经纬度
    NSLog(@"当前的经纬度 %f,%f",currentLocation.coordinate.latitude,currentLocation.coordinate.longitude);
    [[NSUserDefaults standardUserDefaults] setDouble:currentLocation.coordinate.latitude forKey:@"latitude"];
    [[NSUserDefaults standardUserDefaults] setDouble:currentLocation.coordinate.longitude forKey:@"longitude"];

//这里的代码是为了判断didUpdateLocations调用了几次 有可能会出现多次调用 为了避免不必要的麻烦 在这里加个if判断 如果大于1.0就return
    NSTimeInterval locationAge = -[currentLocation.timestamp timeIntervalSinceNow];
    if (locationAge > 1.0){//如果调用已经一次，不再执行
        return;
    }
    NSUserDefaults *defaultss = [NSUserDefaults standardUserDefaults];
    CLGeocoder *clGeoCoder = [[CLGeocoder alloc] init];
    [clGeoCoder reverseGeocodeLocation:currentLocation completionHandler: ^(NSArray *placemarks,NSError *error) {
        for (CLPlacemark *placeMark in placemarks)
        {
            
            NSDictionary *addressDic=placeMark.addressDictionary;//地址的所有信息

            NSString *state=[addressDic objectForKey:@"State"];//省。直辖市  江西省
            NSString *city=[addressDic objectForKey:@"City"];//市  丰城市
            NSString *subLocality=[addressDic objectForKey:@"SubLocality"];//区
            NSString *street=[addressDic objectForKey:@"Street"];//街道
            [defaultss setObject:state forKey:@"province"];
            [defaultss setObject:city forKey:@"locationCity"];
            [defaultss setObject:subLocality forKey:@"subLocality"];
            [defaultss setObject:street forKey:@"street"];
            NSLog(@"=====%@",state);
        }
        
    }];

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
