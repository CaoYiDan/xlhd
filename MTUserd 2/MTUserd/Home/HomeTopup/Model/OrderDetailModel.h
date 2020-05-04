//
//  OrderDetailModel.h
//  MTUserd
//
//  Created by 伯爵 on 2020/1/7.
//  Copyright © 2020 MTShopd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderDetailModel : NSObject

@property (nonatomic ,strong)NSString *order_sn;
@property (nonatomic ,strong)NSString *order_status;
@property (nonatomic ,strong)NSArray *goods;
//@property (nonatomic ,strong)NSString *goods_name;

@end

NS_ASSUME_NONNULL_END
