//
//  UserRightView.h
//  MTShopd
//
//  Created by 伯爵 on 2020/2/20.
//  Copyright © 2020 MTShopd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserRightView : UIView

@property (weak, nonatomic) IBOutlet UIButton *czBtn;
@property (weak, nonatomic) IBOutlet UIButton *ensureBtn;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *typeBtns;
@property (weak, nonatomic) IBOutlet UIButton *xsBtn;
@property (weak, nonatomic) IBOutlet UIButton *xxBtn;
@property (weak, nonatomic) IBOutlet UIButton *buyBtn;
@property (weak, nonatomic) IBOutlet UIButton *yjBtn;
@property (weak, nonatomic) IBOutlet UIButton *timeBtn;

@end

NS_ASSUME_NONNULL_END
