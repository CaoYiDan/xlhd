//
//  DgManegerListCell.h
//  MTShopd
//
//  Created by 伯爵 on 2020/3/18.
//  Copyright © 2020 MTShopd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DgManagerModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DgManegerListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *addressLab;
@property (weak, nonatomic) IBOutlet UILabel *bhLab;
@property (weak, nonatomic) IBOutlet UILabel *dbdsLab;
@property (weak, nonatomic) IBOutlet UILabel *dgwdLab;
@property (weak, nonatomic) IBOutlet UILabel *dgsdLab;
@property (weak, nonatomic) IBOutlet UILabel *zxLab;
@property (weak, nonatomic) IBOutlet UILabel *phoneLab;
@property (nonatomic ,strong)DgManagerModel *model;

- (void)getDataWithInfo:(DgManagerModel *)model;

@end

NS_ASSUME_NONNULL_END
