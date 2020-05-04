//
//  BuyDcView.h
//  MTUserd
//
//  Created by 伯爵 on 2020/1/6.
//  Copyright © 2020 MTShopd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BuyDcView : UIView

@property (weak, nonatomic) IBOutlet UIButton *buyBtn;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bgViewHeight;
@property (nonatomic , strong)NSString *goodId;

- (void)getDataWithInfo:(NSArray *)datas;

@end

NS_ASSUME_NONNULL_END
