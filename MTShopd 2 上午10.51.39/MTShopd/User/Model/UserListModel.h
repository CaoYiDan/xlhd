//
//  UserListModel.h
//  MTShopd
//
//  Created by 伯爵 on 2020/1/21.
//  Copyright © 2020 MTShopd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserListModel : NSObject

@property (nonatomic ,strong)NSString *phone_number;
@property (nonatomic ,strong)NSString *bind_time;
@property (nonatomic ,strong)NSString *use_battery_status;

@end

NS_ASSUME_NONNULL_END
