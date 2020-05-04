//
//  YuEView.h
//  MTShopd
//
//  Created by 伯爵 on 2019/11/8.
//  Copyright © 2019 MTShopd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YuEView : UIView

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttons;
@property (weak, nonatomic) IBOutlet UIButton *txBtn;
@property (weak, nonatomic) IBOutlet UILabel *yueLab;


@end

NS_ASSUME_NONNULL_END
