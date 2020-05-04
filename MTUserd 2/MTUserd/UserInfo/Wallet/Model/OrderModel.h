//
//  OrderModel.h
//  MTUserd
//
//  Created by 伯爵 on 2020/1/8.
//  Copyright © 2020 MTShopd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderModel : NSObject

@property (nonatomic ,strong)NSString *created_at;
@property (nonatomic ,strong)NSString *order_amount;
@property (nonatomic ,strong)NSString *order_sn;
@property (nonatomic ,strong)NSArray *goods;

@end

NS_ASSUME_NONNULL_END
