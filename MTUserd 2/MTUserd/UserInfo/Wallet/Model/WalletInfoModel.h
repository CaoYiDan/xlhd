//
//  WalletInfoModel.h
//  MTUserd
//
//  Created by 伯爵 on 2020/1/8.
//  Copyright © 2020 MTShopd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WalletInfoModel : NSObject

@property (nonatomic ,strong)NSString *gold;
@property (nonatomic ,strong)NSString *days;
@property (nonatomic ,strong)NSString *times;
@property (nonatomic ,strong)NSString *deposit;
@property (nonatomic ,assign)NSInteger buy_status;
@property (nonatomic ,assign)NSInteger deposit_status;


@end

NS_ASSUME_NONNULL_END
