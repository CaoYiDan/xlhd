//
//  HomeDetailModel.h
//  YunWeiYuan
//
//  Created by 伯爵 on 2020/3/9.
//  Copyright © 2020 GangMeiTanGongXu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DetailInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeDetailModel : NSObject

@property (nonatomic ,strong)NSString *cabinet_name;
@property (nonatomic ,strong)NSString *device_code;
@property (nonatomic ,strong)NSString *address;
@property (nonatomic ,strong)NSString *business;
@property (nonatomic ,strong)NSString *last_check_time;
@property (nonatomic ,strong)NSString *tel;
@property (nonatomic ,strong)NSString *cabinet_status;
@property (nonatomic ,strong)NSString *battery_number;
@property (nonatomic ,strong)NSMutableArray *ports;

@end

NS_ASSUME_NONNULL_END
