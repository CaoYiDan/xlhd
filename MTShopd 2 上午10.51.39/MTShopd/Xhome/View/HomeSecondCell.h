//
//  HomeSecondCell.h
//  MTShopd
//
//  Created by 伯爵 on 2020/2/17.
//  Copyright © 2020 MTShopd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeSyModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HomeSecondCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *xxyjLab;
@property (weak, nonatomic) IBOutlet UILabel *xxsdcLab;

- (void)getDataWithInfo:(HomeSyModel *)model;

@end

NS_ASSUME_NONNULL_END
