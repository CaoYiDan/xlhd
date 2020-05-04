//
//  DgManagerModel.h
//  MTShopd
//
//  Created by 伯爵 on 2020/3/18.
//  Copyright © 2020 MTShopd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DgManagerModel : NSObject

@property (nonatomic ,strong)NSString *device_code;
@property (nonatomic ,strong)NSString *name;
@property (nonatomic ,strong)NSString *create_time;
@property (nonatomic ,strong)NSString *address;
@property (nonatomic ,strong)NSString *tel;
@property (nonatomic ,strong)NSString *business;
@property (nonatomic ,strong)NSString *power;
@property (nonatomic ,strong)NSString *humidity;
@property (nonatomic ,strong)NSString *temperature;
@property (nonatomic ,assign)NSInteger status;

@end

NS_ASSUME_NONNULL_END
