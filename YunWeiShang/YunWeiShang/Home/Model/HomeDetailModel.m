
//
//  HomeDetailModel.m
//  YunWeiYuan
//
//  Created by 伯爵 on 2020/3/9.
//  Copyright © 2020 GangMeiTanGongXu. All rights reserved.
//

#import "HomeDetailModel.h"

@implementation HomeDetailModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"ports" : [DetailInfoModel class],
            
             };
}


@end
