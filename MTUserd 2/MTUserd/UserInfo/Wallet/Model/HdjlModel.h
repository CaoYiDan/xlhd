//
//  HdjlModel.h
//  MTUserd
//
//  Created by 伯爵 on 2020/1/13.
//  Copyright © 2020 MTShopd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HdjlModel : NSObject

@property (nonatomic ,strong)NSString *replace_time;
@property (nonatomic ,strong)NSString *device_code;
@property (nonatomic ,strong)NSString *cabinet_name;
@property (nonatomic ,strong)NSDictionary *charging_cabinet;
@property (nonatomic ,strong)NSString *cabinet_address;
@property (nonatomic ,strong)NSString *to_bms_id;
@property (nonatomic ,strong)NSString *name;

@end

NS_ASSUME_NONNULL_END
