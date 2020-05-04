//
//  DetailInfoModel.h
//  YunWeiYuan
//
//  Created by 伯爵 on 2020/3/9.
//  Copyright © 2020 GangMeiTanGongXu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailInfoModel : NSObject

@property (nonatomic ,strong)NSString *port;
@property (nonatomic ,strong)NSString *power;
@property (nonatomic ,strong)NSString *voltage;
@property (nonatomic ,strong)NSString *electron_flow;
@property (nonatomic ,strong)NSString *soc;
@property (nonatomic ,strong)NSString *soh;
@property (nonatomic ,strong)NSString *temperature;
@property (nonatomic ,strong)NSString *port_status;

@end

NS_ASSUME_NONNULL_END
