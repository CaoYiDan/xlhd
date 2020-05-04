//
//  HomeTopModel.h
//  MTShopd
//
//  Created by 伯爵 on 2020/3/19.
//  Copyright © 2020 MTShopd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeTopModel : NSObject

@property (nonatomic ,strong)NSString *balance;
@property (nonatomic ,strong)NSString *total;
@property (nonatomic ,strong)NSString *withdrawn;
@property (nonatomic ,strong)NSString *withdrawing;

@end

NS_ASSUME_NONNULL_END
