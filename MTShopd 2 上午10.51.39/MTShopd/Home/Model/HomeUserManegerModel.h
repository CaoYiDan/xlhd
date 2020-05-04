//
//  HomeUserManegerModel.h
//  MTShopd
//
//  Created by 伯爵 on 2019/12/28.
//  Copyright © 2019 MTShopd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeUserManegerModel : NSObject

@property (nonatomic ,strong)NSString *battery_percentage;
@property (nonatomic ,strong)NSString *device_code;
@property (nonatomic ,strong)NSString *lat;
@property (nonatomic ,strong)NSString *lng;
@property (nonatomic ,strong)NSString *status;
@property (nonatomic ,strong)NSString *battery_code;
@property (nonatomic ,strong)NSString *bind_user;
@property (nonatomic ,assign)NSInteger battery_status;
@property (nonatomic ,strong)NSString *bms_id;

@end

NS_ASSUME_NONNULL_END
