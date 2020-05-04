//
//  HomeDianGuiModel.h
//  MTUserd
//
//  Created by 伯爵 on 2019/12/26.
//  Copyright © 2019 MTShopd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeYyInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeDianGuiModel : NSObject

@property (nonatomic ,strong)NSString *lat;
@property (nonatomic ,strong)NSString *lng;
@property (nonatomic ,strong)NSString *device_code;
@property (nonatomic ,strong)NSString *batteries;
@property (nonatomic ,assign)NSInteger status;
@property (nonatomic ,strong)NSDictionary *book;

@property (nonatomic ,strong)NSString *address;
@property (nonatomic ,strong)NSString *name;


@end

NS_ASSUME_NONNULL_END
