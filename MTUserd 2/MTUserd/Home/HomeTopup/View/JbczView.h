//
//  JbczView.h
//  MTUserd
//
//  Created by 伯爵 on 2019/12/24.
//  Copyright © 2019 MTShopd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JbczView : UIView

@property (weak, nonatomic) IBOutlet UIButton *buyBtn;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bgViewHeight;
@property (nonatomic , strong)NSMutableArray *viewArray;
@property (nonatomic , strong)NSArray *dataArray;
@property (nonatomic , strong)NSString *goodId;
- (void)getDataWithInfo:(NSArray *)datas;

@end

NS_ASSUME_NONNULL_END
