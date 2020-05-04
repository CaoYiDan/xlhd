//
//  MyBreakdownModel.h
//  MTUserd
//
//  Created by 伯爵 on 2020/1/3.
//  Copyright © 2020 MTShopd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyBreakdownModel : NSObject

@property (nonatomic ,assign)NSInteger status;
@property (nonatomic ,strong)NSString *ticket_sn;
@property (nonatomic ,strong)NSString *title;

@end

NS_ASSUME_NONNULL_END
