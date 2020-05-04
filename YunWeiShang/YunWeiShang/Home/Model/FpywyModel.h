//
//  FpywyModel.h
//  YunWeiShang
//
//  Created by 伯爵 on 2020/3/11.
//  Copyright © 2020 GangMeiTanGongXu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FpywyModel : NSObject

@property (nonatomic ,strong)NSString *phone_number;
@property (nonatomic ,strong)NSString *tse_id;
@property (nonatomic ,strong)NSString *name;
@property (nonatomic ,assign)BOOL selected;

@end

NS_ASSUME_NONNULL_END
