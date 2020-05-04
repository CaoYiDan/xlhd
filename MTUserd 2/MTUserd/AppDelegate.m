//
//  AppDelegate.m
//  MTUserd
//
//  Created by 伯爵 on 2019/11/11.
//  Copyright © 2019 MTShopd. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "LoginViewController.h"
#import <WXApi.h>
#import <AlipaySDK/AlipaySDK.h>
@interface AppDelegate ()<CLLocationManagerDelegate,WXApiDelegate>

@property (nonatomic,strong ) CLLocationManager *locationManager;

@end

@implementation AppDelegate

+ (id)delegate{
    return [UIApplication sharedApplication].delegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(rootVCChangeToHomeVC) name:@"RootVCChangeToHomeVC" object:nil];
    
//    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    
    if (Token) {
        [self rootVCChangeToHomeVC];
    }else{
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        BaseNavigationController *nav = [[BaseNavigationController alloc]initWithRootViewController:loginVC];
        self.window.rootViewController = nav;
        [self.window makeKeyAndVisible];
    }
    
    //高德地图
    [AMapServices sharedServices].apiKey = @"b49e85ddd9ccc93b1c51fa3d6ec72fd0";

    [self locatemap];
    
    //支付宝
//    [AlipaySDK rei];

    [self startWX];
    
    return YES;
}

-(void)startWX{
    
    
     //向微信注册
    if ([WXApi registerApp:@"wxf9459aa4d06036a2" universalLink:@"https://ysjlink/YSJ/"]) {
        NSLog(@"微信注册成功");
    }else{
         NSLog(@"失败");
    } ;
    
}
-(void)rootVCChangeToHomeVC{
    
    HomeViewController *homeVC = [[HomeViewController alloc]init];
    BaseNavigationController *nav = [[BaseNavigationController alloc]initWithRootViewController:homeVC];
    self.window.rootViewController = nav;
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

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return  [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
    }
    return [WXApi handleOpenURL:url delegate:self];
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
    }
    return YES;
}

@end
