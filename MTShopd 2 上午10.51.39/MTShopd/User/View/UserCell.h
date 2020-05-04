//
//  UserCell.h
//  MTShopd
//
//  Created by 伯爵 on 2019/11/7.
//  Copyright © 2019 MTShopd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserCell : UITableViewCell<UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *accountLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *yajinLab;
@property (weak, nonatomic) IBOutlet UIButton *jyjBtn;
@property (weak, nonatomic) IBOutlet UIButton *jbBtn;
@property (nonatomic ,strong)UserListModel *model;

- (void)getDataWithInfo:(UserListModel *)model;

@end

NS_ASSUME_NONNULL_END
