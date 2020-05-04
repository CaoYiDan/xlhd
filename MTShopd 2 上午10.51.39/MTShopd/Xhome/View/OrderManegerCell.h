//
//  OrderManegerCell.h
//  MTShopd
//
//  Created by 伯爵 on 2020/4/16.
//  Copyright © 2020 MTShopd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderManagerModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface OrderManegerCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *ordersnLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *typeLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UIButton *payBtn;

- (void)getDataWithInfo:(OrderManagerModel *)model;

@end

NS_ASSUME_NONNULL_END
