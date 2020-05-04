//
//  BatteryModel.h
//  MTUserd
//
//  Created by 伯爵 on 2019/12/27.
//  Copyright © 2019 MTShopd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BatteryModel : NSObject

@property (nonatomic ,strong)NSString *battery_percentage;
@property (nonatomic ,strong)NSString *device_code;
@property (nonatomic ,strong)NSString *status;
@property (nonatomic ,strong)NSString *merchant_name;

@end

NS_ASSUME_NONNULL_END
