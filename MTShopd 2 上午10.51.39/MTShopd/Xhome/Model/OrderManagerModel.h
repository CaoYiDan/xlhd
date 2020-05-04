//
//  OrderManagerModel.h
//  MTShopd
//
//  Created by 伯爵 on 2020/4/16.
//  Copyright © 2020 MTShopd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderManagerModel : NSObject

@property (nonatomic ,strong)NSString *user_name;
@property (nonatomic ,strong)NSString *order_sn;
@property (nonatomic ,strong)NSString *create_time;
@property (nonatomic ,strong)NSString *order_price;
@property (nonatomic ,strong)NSString *order_type;
@property (nonatomic ,strong)NSString *order_status;

@end

NS_ASSUME_NONNULL_END
