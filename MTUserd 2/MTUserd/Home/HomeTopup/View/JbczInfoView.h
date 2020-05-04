//
//  JbczInfoView.h
//  MTUserd
//
//  Created by 伯爵 on 2020/1/6.
//  Copyright © 2020 MTShopd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JbczInfoView : UIView

@property (weak, nonatomic) IBOutlet UILabel *goodLab;
@property (weak, nonatomic) IBOutlet UILabel *xPriceLab;
@property (weak, nonatomic) IBOutlet UILabel *oldPriceLab;
@property (weak, nonatomic) IBOutlet UIButton *chooseBtn;

@end

NS_ASSUME_NONNULL_END
