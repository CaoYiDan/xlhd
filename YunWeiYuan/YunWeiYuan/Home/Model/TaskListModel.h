//
//  TaskListModel.h
//  YunWeiYuan
//
//  Created by 伯爵 on 2020/3/8.
//  Copyright © 2020 GangMeiTanGongXu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TaskListModel : NSObject

@property (nonatomic ,strong)NSString *device_code;
@property (nonatomic ,strong)NSString *address;
@property (nonatomic ,strong)NSString *describe;
@property (nonatomic ,strong)NSString *repair_id;
@property (nonatomic ,assign)NSInteger repair_status;

@end

NS_ASSUME_NONNULL_END
