//
//  BaseModel.h
//  crane
//
//  Created by sos on 16/5/31.
//  Copyright © 2016年 sos. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject
@property (nonatomic,copy) NSString *myId;

//初始化
- (instancetype) initWithDic:(NSDictionary *)dic;
//便利构造器
+(instancetype)modelWithDic:(NSDictionary *)dic;


//数组＋字典－> 数组＋对象
+(NSMutableArray *)modelHandlerWithArray:(NSArray *)arr;
@end
