//
//  GzListModel.h
//  YunWeiShang
//
//  Created by 伯爵 on 2020/3/11.
//  Copyright © 2020 GangMeiTanGongXu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GzListModel : NSObject

@property (nonatomic ,strong)NSString *warning_id;
@property (nonatomic ,strong)NSString *cabinet_address;
@property (nonatomic ,assign)NSInteger finished;
@property (nonatomic ,assign)NSInteger allow_assign;

@end

NS_ASSUME_NONNULL_END
