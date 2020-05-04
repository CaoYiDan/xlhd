//
//  YwyListModel.h
//  YunWeiShang
//
//  Created by 伯爵 on 2020/3/10.
//  Copyright © 2020 GangMeiTanGongXu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YwyListModel : NSObject

@property (nonatomic ,strong)NSString *name;
@property (nonatomic ,strong)NSString *phone_number;
@property (nonatomic ,strong)NSString *created_at;
@property (nonatomic ,strong)NSString *address;
@property (nonatomic ,strong)NSString *status;

@end

NS_ASSUME_NONNULL_END
