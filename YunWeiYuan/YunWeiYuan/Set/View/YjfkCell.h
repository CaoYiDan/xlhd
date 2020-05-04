//
//  YjfkCell.h
//  MTUserd
//
//  Created by 伯爵 on 2019/11/12.
//  Copyright © 2019 MTShopd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YjfkInfoModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface YjfkCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;

- (void)getDataWithInfo:(YjfkInfoModel *)model;

@end

NS_ASSUME_NONNULL_END
