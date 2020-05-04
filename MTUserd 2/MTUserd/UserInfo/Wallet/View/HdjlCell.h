//
//  HdjlCell.h
//  MTUserd
//
//  Created by 伯爵 on 2020/1/13.
//  Copyright © 2020 MTShopd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HdjlModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HdjlCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *hdzLab;
@property (weak, nonatomic) IBOutlet UILabel *dcbmLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;

- (void)getDataWithInfo:(HdjlModel *)model;

@end

NS_ASSUME_NONNULL_END
