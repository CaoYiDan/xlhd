//
//  UserRightView.m
//  MTShopd
//
//  Created by 伯爵 on 2020/2/20.
//  Copyright © 2020 MTShopd. All rights reserved.
//

#import "UserRightView.h"

@implementation UserRightView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.3f];
    [self.czBtn setBorderLineWithColor:mainColor];
}


@end
