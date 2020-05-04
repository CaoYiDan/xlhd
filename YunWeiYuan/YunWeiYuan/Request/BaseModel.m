//
//  BaseModel.m
//  crane
//
//  Created by sos on 16/5/31.
//  Copyright © 2016年 sos. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel
-(instancetype)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {


        [self setValuesForKeysWithDictionary:dic];
    }
    
    return self;
    
    
}

+(instancetype)modelWithDic:(NSDictionary *)dic
{
    //self class 表示当前类
    id m = [[[self class] alloc] initWithDic:dic];
    return m;
    
    
}

+(NSMutableArray *)modelHandlerWithArray:(NSArray *)arr
{
    //1.创建空数组 保存处理后的model对象
    NSMutableArray *mArr = [NSMutableArray array];
    //2.遍历传入的数组参数 得到每个字典信息
    for (NSDictionary *dic in arr) {
        //3.使用kvc转换对象
        id m = [[self class] modelWithDic:dic];
        //4.添加到数组
        [mArr addObject:m];
        
    }
    
    return mArr;
    
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
    
    if ([key isEqualToString:@"id"]) {
        
        self.myId = value;
    }

    
}

@end
