//
//  OrderCell.h
//  MTUserd
//
//  Created by 伯爵 on 2020/1/8.
//  Copyright © 2020 MTShopd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface OrderCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *orderXmLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *dcbmLab;
@property (weak, nonatomic) IBOutlet UILabel *orderSnLab;

- (void)getDataWithInfo:(OrderModel *)model;

@end

NS_ASSUME_NONNULL_END
