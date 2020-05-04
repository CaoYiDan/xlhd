//
//  MessageModel.h
//  MTUserd
//
//  Created by 伯爵 on 2020/1/15.
//  Copyright © 2020 MTShopd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MessageModel : NSObject

@property (nonatomic ,strong)NSString *content;
@property (nonatomic ,strong)NSString *created_at;
@property (nonatomic ,strong)NSString *title;

@end

NS_ASSUME_NONNULL_END
