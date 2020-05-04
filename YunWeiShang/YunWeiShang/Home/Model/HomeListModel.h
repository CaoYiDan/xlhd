//
//  HomeListModel.h
//  YunWeiYuan
//
//  Created by 伯爵 on 2020/3/9.
//  Copyright © 2020 GangMeiTanGongXu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeListModel : NSObject

@property (nonatomic ,strong)NSString *cabinet_name;
@property (nonatomic ,strong)NSString *device_code;
@property (nonatomic ,strong)NSString *address;
@property (nonatomic ,strong)NSString *last_check_time;
@property (nonatomic ,strong)NSString *cabinet_status;
@property (nonatomic ,strong)NSString *lat;
@property (nonatomic ,strong)NSString *lng;

@end

NS_ASSUME_NONNULL_END
