//
//  HomeDetailView.h
//  YunWeiYuan
//
//  Created by 伯爵 on 2020/2/24.
//  Copyright © 2020 GangMeiTanGongXu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeDetailView : UIView

@property (weak, nonatomic) IBOutlet UILabel *dgbhLab;
@property (weak, nonatomic) IBOutlet UILabel *zdlxLab;
@property (weak, nonatomic) IBOutlet UILabel *zdNameLab;
@property (weak, nonatomic) IBOutlet UILabel *zdAddressLab;
@property (weak, nonatomic) IBOutlet UILabel *yyTimeLab;
@property (weak, nonatomic) IBOutlet UILabel *dcNumLab;
@property (weak, nonatomic) IBOutlet UILabel *phoneLab;

- (void)getDataWithInfo:(HomeDetailModel *)model;

@end

NS_ASSUME_NONNULL_END
